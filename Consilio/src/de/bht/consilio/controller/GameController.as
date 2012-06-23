package de.bht.consilio.controller
{
	import de.bht.consilio.anim.Attributes;
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.application.ConsilioApplication;
	import de.bht.consilio.board.Board;
	import de.bht.consilio.board.Square;
	import de.bht.consilio.custom_components.view.ActionMenu;
	import de.bht.consilio.custom_components.view.BottomMenu;
	import de.bht.consilio.gsdl.Turn;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import spark.core.SpriteVisualElement;
	
	public class GameController extends EventDispatcher
	{	
		public static var instance:GameController;
		private var _isOwnTurn:Boolean;
		private var _bottomMenu:BottomMenu;
		private var _board:Board;
		private var _actionMenu:ActionMenu;
		private var _activeSquares:Array;
		
		public function GameController(board:Board, actionMenu:ActionMenu, isOwnTurn:Boolean, p_key:SingletonBlocker)
		{
			_board = board;
			_bottomMenu = ConsilioApplication.getInstance().bottomMenu;
			_actionMenu = actionMenu;
			_isOwnTurn = isOwnTurn;
			if(_isOwnTurn) {
				startTurn();
			}
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
			RemoteServiceController.getInstance().addEventListener(RemotingEvent.GAME_MESSAGE_RECEIVED, onOpponentTurn);
			
			for each (var s:Square in _board.squares)
			{
				if(s.registeredPiece)
				{
					s.makeSelectable(true);
				}
			}
		}
		
		public function endTurn():void
		{
			for each (var s:Square in _activeSquares) 
			{
				
			}
			
			_isOwnTurn = !_isOwnTurn;
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
			};
		}
		
		private function onOpponentTurn(e:RemotingEvent):void {
			var opTurn:Turn = e.data as Turn;
			if(opTurn.action == "move") {
				trace("OpTurn Action = " + opTurn.action);
				_board.getSquare(opTurn.source).registeredPiece.moveTo(_board.getSquare(opTurn.target));
			}
			
			_isOwnTurn = !_isOwnTurn;
			startTurn();
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
			_actionMenu.x = square.x;
			_actionMenu.y = square.y;
			_actionMenu.setActionController(square.registeredPiece.control);
			_actionMenu.visible = true;
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
	}
}
internal class SingletonBlocker {}