package de.bht.consilio.controller
{
	import de.bht.consilio.anim.AnimationEvent;
	import de.bht.consilio.anim.Attributes;
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.application.ConsilioApplication;
	import de.bht.consilio.board.Board;
	import de.bht.consilio.board.Square;
	import de.bht.consilio.custom_components.event.ActionEvent;
	import de.bht.consilio.custom_components.view.ActionMenu;
	import de.bht.consilio.custom_components.view.BottomMenu;
	import de.bht.consilio.event.ActionEvent;
	import de.bht.consilio.event.ConsilioEvent;
	import de.bht.consilio.gsdl.Turn;
	import de.bht.consilio.iso.IsoUtils;
	import de.bht.consilio.util.Constants;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;
	
	import spark.core.SpriteVisualElement;
	
	public class GameController extends EventDispatcher
	{	
		public static var instance:GameController;
		private var _isOwnTurn:Boolean;
		private var _bottomMenu:BottomMenu;
		private var _board:Board;
		private var _actionMenu:ActionMenu;
		private var _activeSquares:Array;
		
		private var _powerWhite:uint;
		private var _powerBlack:uint;
		
		private var _isWhitePlayer:Boolean;
		private var _currentTurn:uint;
		
		private var _battleTheme:Sound;
		private var _battleThemeChannel:SoundChannel;
		
		public function GameController(board:Board, actionMenu:ActionMenu, isOwnTurn:Boolean, p_key:SingletonBlocker)
		{
			_board = board;
			_bottomMenu = ConsilioApplication.getInstance().bottomMenu;
			_actionMenu = actionMenu;
			_isOwnTurn = isOwnTurn;
			trace("Own Turn: " + isOwnTurn);
			
			var file:File = File.applicationDirectory;
			var urlRequest:URLRequest = new URLRequest(file.nativePath + Constants.BATTLE_THEME); 
			
			_battleTheme = new Sound(urlRequest);
			_battleTheme.addEventListener(Event.COMPLETE, function(e:Event):void {
				playBattleTheme();
			});
			_battleTheme.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
				trace(e.text);
			});
			
			_isWhitePlayer = isOwnTurn;
			
			_currentTurn = 1;
			
			if(_isOwnTurn) {
				RemoteServiceController.getInstance().addEventListener(RemotingEvent.PLAYER_JOINED, startGame);
			} else {
				calculatePowers();
				ConsilioApplication.getInstance().initStatusBar(ConsilioApplication.getInstance().getOpponentId(), ConsilioApplication.getInstance().getUserId(), _powerWhite, _powerBlack, 1);
				RemoteServiceController.getInstance().addEventListener(RemotingEvent.GAME_MESSAGE_RECEIVED, onOpponentTurn);
			}
		}
		
		private function startGame(e:RemotingEvent):void {
			RemoteServiceController.getInstance().removeEventListener(RemotingEvent.PLAYER_JOINED, startGame);
			ConsilioApplication.getInstance().setOpponentId(e.message);
			calculatePowers();
			ConsilioApplication.getInstance().initStatusBar(ConsilioApplication.getInstance().getUserId(), e.message, _powerWhite, _powerBlack, 0);
			ConsilioApplication.getInstance().disableBusyIndicator();
			startTurn();
		}
		
		public static function newGameController(board:Board, actionMenu:ActionMenu, isOwnTurn:Boolean):GameController
		{
			instance = new GameController(board, actionMenu, isOwnTurn, new SingletonBlocker());
			return instance;
		}
		
		public static function getInstance():GameController {
			if (instance == null) {
				throw new Error("Error in GameController: Called getInstance() before newGameController(...)");
			}
			return instance;
		}
		
		public function startTurn():void
		{
			trace("Turn started");
			ConsilioApplication.getInstance().updateStatusBar(_powerWhite, _powerBlack, ++_currentTurn);
			_isOwnTurn = true;
			for each (var s:Square in _board.squares)
			{
				if(s.registeredPiece)
				{
					s.makeSelectable(true);
					s.registeredPiece.canStartIdleAnimation(true);
				}
			}
		}
		
		public function endTurn():void
		{
			trace("Turn finished");
			calculatePowers();
			ConsilioApplication.getInstance().updateStatusBar(_powerWhite, _powerBlack, ++_currentTurn);
			for each (var s:Square in _board.squares)
			{
				s.makeSelectable(false);
			}
			_isOwnTurn = false;
			
			RemoteServiceController.getInstance().addEventListener(RemotingEvent.GAME_MESSAGE_RECEIVED, onOpponentTurn);
			ConsilioApplication.getInstance().showBusyIndicator("Waiting for opponents turn");
		}
		
		public function disableAllActions():void {
			
			detachActionMenu();
			
			for(var i:String in _board.squares)
			{
				var s:Square = _board.squares[i];
				s.removeCurrentClickAction();
				s.redraw(s.color);
			};
		}
		
		public function disableSelections():void {
			
			detachActionMenu();
			
			for(var i:String in _board.squares)
			{
				var s:Square = _board.squares[i];
				s.redraw(s.color);
				if(s.registeredPiece) {
					s.registeredPiece.stopCurrentAnimation();
				}
			};
		}
		
		private function onOpponentTurn(e:RemotingEvent):void {
			
			RemoteServiceController.getInstance().removeEventListener(RemotingEvent.GAME_MESSAGE_RECEIVED, onOpponentTurn);
			ConsilioApplication.getInstance().disableBusyIndicator();
			
			var opTurn:Object = e.data;
			if(opTurn.action == "move") {
				trace("OpTurn Action = " + opTurn.action);
				_board.getSquare(opTurn.source).registeredPiece.addEventListener(Event.COMPLETE, function(e:Event):void {
					e.currentTarget.removeEventListener( e.type, arguments.callee );
					startTurn();
				});
				_board.getSquare(opTurn.source).registeredPiece.moveTo(_board.getSquare(opTurn.target));
			} else if (opTurn.action == "attack") {
				trace("OpTurn Action = " + opTurn.action);
				_board.getSquare(opTurn.target).registeredPiece.addEventListener(Event.COMPLETE, function(e:Event):void {
					e.currentTarget.removeEventListener( e.type, arguments.callee );
					calculatePowers();
					startTurn();
				});
				_board.getSquare(opTurn.source).registeredPiece.attack(_board.getSquare(opTurn.target).registeredPiece);
			}
		}
		
		
		private function playBattleTheme():void {
			_battleThemeChannel = _battleTheme.play();
			_battleThemeChannel.addEventListener(Event.SOUND_COMPLETE, function(e:Event):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				playBattleTheme();
			});
		}
		
		public function get squares() : Dictionary {
			return _board.squares;
		}
		
		public function getSquareById(id:String):Square
		{
			return _board.getSquare(id);
		}
		
		public function get isOwnTurn():Boolean {
			return _isOwnTurn;
		}
		
		public function attachActionMenu(square:Square):void {
			
			//TODO: correct the position
			var screenPosition:Point = IsoUtils.isoToScreen(square.registeredPiece.position);
			_actionMenu.x = screenPosition.x + 550;
			_actionMenu.y = screenPosition.y - 30;
			_actionMenu.setActionController(square.registeredPiece.control);
			_actionMenu.visible = true;
		}
		
		public function hideActionMenu():void {
			_actionMenu.visible = false;
		}
		
		private function detachActionMenu():void {
			_actionMenu.removeActionController();
			_actionMenu.visible = false;
		}
		
		/**
		 * Sets an entry in the bottom menu
		 * 
		 * @param pic the pieces picture
		 * @param attackValue the pieces attack value
		 * @param defenseValue the pieces defense value
		 * @param moveValue the pieces moveValue
		 * @param moveTypeValue the pieces moce type (ie "diagonal")
		 * 
		 */
		public function setMenuEntry(piece:Piece):void
		{
			_bottomMenu.attack_label.text = "" + piece.attributes.attack;
			_bottomMenu.defense_label.text = "" + piece.attributes.defense;
			_bottomMenu.move_label.text = "" + piece.attributes.movement;
			_bottomMenu.move_type_label.text = piece.attributes.movementType;
			_bottomMenu.imageContainer.removeAllElements();
			
			var s:SpriteVisualElement = new SpriteVisualElement();
			s.addChild(piece.picture);
			
			_bottomMenu.imageContainer.addElement(s);
			_bottomMenu.hp_bar.minimum = 0;
			_bottomMenu.hp_bar.label = "HP: "+ piece.attributes.currentHP + "/" + piece.attributes.maxHP;
			_bottomMenu.hp_bar.setProgress(piece.attributes.currentHP, piece.attributes.maxHP);
		}
		
		
		public function removeFromGame(piece:Piece):void {
			if((piece.name == "bjorn" && !_isWhitePlayer) || (piece.name == "black_knight" && _isWhitePlayer)) {
				handleGameWon();
			} else if ((piece.name == "bjorn" && _isWhitePlayer) || (piece.name == "black_knight" && !_isWhitePlayer)) {
				handleGameLost();
			}
			var s:Square = getSquareById(piece.boardPosition);
			s.removeCurrentClickAction();
			s.registeredPiece = null;
			s.isOccupied = false;
			s.makeSelectable(false);
			_board.removeChild(piece);
		}
		
		private function handleGameWon():void {
			Alert.show("WOW, you won the game. We'll go and tell your opponent about it.");
		}
		
		private function handleGameLost():void {
			Alert.show("OMG, you lost the game. Better luck next time...");
		}
		
		private function calculatePowers():void {
			var pW:uint = 0;
			var pB:uint = 0;
			for(var i:String in _board.squares)
			{
				var s:Square = _board.squares[i];
				
				if(s.registeredPiece) {
					if(s.registeredPiece.isOwnPiece) {
						if(_isWhitePlayer) {
							pW += (s.registeredPiece.attributes.attack + s.registeredPiece.attributes.defense) * s.registeredPiece.attributes.currentHP;
						} else {
							pB += (s.registeredPiece.attributes.attack + s.registeredPiece.attributes.defense) * s.registeredPiece.attributes.currentHP;
						}
					} else {
						if(_isWhitePlayer) {
							pB += (s.registeredPiece.attributes.attack + s.registeredPiece.attributes.defense) * s.registeredPiece.attributes.currentHP;
						} else {
							pW += (s.registeredPiece.attributes.attack + s.registeredPiece.attributes.defense) * s.registeredPiece.attributes.currentHP;
						}
					}
				}
			}
			_powerWhite = pW;
			_powerBlack = pB;
		}
		
	}
}
internal class SingletonBlocker {}