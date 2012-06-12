package de.bht.consilio.controller
{
	import de.bht.ConsilioCustomComponents.BottomMenu;
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.application.ConsilioApplication;
	import de.bht.consilio.board.Board;
	import de.bht.consilio.board.Square;
	import de.bht.consilio.event.BoardEvent;
	import de.bht.consilio.game.ConsilioGame;
	import de.bht.consilio.iso.IsoUtils;
	import de.bht.consilio.util.Constants;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import spark.core.SpriteVisualElement;
	
	public class GameController extends EventDispatcher
	{	
		private var _isOwnTurn:Boolean;
		private var _bottomMenu:BottomMenu;
		private var _board:Board;
		private var _selectedSquare:Square;
		
		public function GameController(board:Board, isOwnTurn:Boolean)
		{
			_board = board;
			_bottomMenu = ConsilioApplication.getInstance().bottomMenu;
			_isOwnTurn = isOwnTurn;
			if(_isOwnTurn) {
				startTurn();
			}
		}
		
		private function startTurn():void
		{
			for each (var s:Square in _board.squares)
			{
				if(s.registeredPiece && s.registeredPiece.isOwnPiece)
				{
					s.addEventListener(MouseEvent.CLICK, onClick);
				}
			}
		}
		
		private function endTurn():void
		{
			for each (var s:Square in _board.squares)
			{
				if(s.registeredPiece && s.registeredPiece.isOwnPiece)
				{
					s.removeEventListener(MouseEvent.CLICK, onClick);
				}
			}
		}
		
		private function onClick(e:Event):void
		{
			trace("click");
			
			var s:Square = e.target as Square;
			
			
			
			if(!s.isSelected())
			{
				s.removeEventListener(MouseEvent.CLICK, onClick);
				
				if(_selectedSquare != null)
				{
					deactivateAccessibleSquares();
					deselectSquare();
				}
				
				setAsSelectedSquare(s);
				
				activateAccessibleSquares(s);			
			}
		}
		
		private function setAsSelectedSquare(s:Square): void
		{
			_selectedSquare = s;
			var current:Piece = s.registeredPiece;
			current.startCurrentAnimation();
			setMenuEntry(current.picture, 2, 2, 1, current.movementType.getType() ,current.maxLivePoints,current.livePoints);
			s.redraw(Constants.SQUARE_COLOR_SELECTED);
		}
		
		private function activateAccessibleSquares(s:Square):void
		{
			var res:Array = s.registeredPiece.movementType.getAccessableSquares(s.id);
			
			for(var i:String in res)
			{
				var s:Square = (_board.squares[res[i]] as Square);
				if(!s.isOccupied)
				{
					s.addEventListener(MouseEvent.CLICK, moveTo);
					s.redraw(Constants.SQUARE_COLOR_EMPTY_TARGET);
				}
			}
		}
		
		private function deactivateAccessibleSquares():void
		{
			var res:Array = _selectedSquare.registeredPiece.movementType.getAccessableSquares(_selectedSquare.id);
			
			for(var i:String in res)
			{
				var s:Square = (_board.squares[res[i]] as Square);
				if(!s.isOccupied)
				{
					s.removeEventListener(MouseEvent.CLICK, moveTo);
					s.redraw(s.color);
				}
			}
		}
		
		private function deselectSquare():void
		{
			_selectedSquare.setSelected(false);
			_selectedSquare.registeredPiece.stopCurrentAnimation();
			_selectedSquare.redraw(_selectedSquare.color);
			_selectedSquare.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function moveTo(e:Event):void
		{
			e.currentTarget.removeEventListener( e.type, arguments.callee );
			
			var target:Square = e.target as Square;
			
			_selectedSquare.registeredPiece.moveTo(target);
			_selectedSquare.setSelected(false);
			_selectedSquare.registeredPiece.stopCurrentAnimation();
			target.registeredPiece = _selectedSquare.registeredPiece;
			target.addEventListener(MouseEvent.CLICK, onClick);
			_selectedSquare.registeredPiece = null;
			_selectedSquare.isOccupied = false;
			target.redraw(target.color);
			_selectedSquare.redraw(_selectedSquare.color);
			
			_selectedSquare = null;
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
		private function setMenuEntry(pic:Bitmap, attackValue:uint, defenseValue:uint, moveValue:uint, moveTypeValue:String, hp_max:uint, hp_akt:uint):void
		{
			_bottomMenu.attack_label.text = "" + attackValue;
			_bottomMenu.defense_label.text = "" + defenseValue;
			_bottomMenu.move_label.text = "" + moveValue;
			_bottomMenu.move_type_label.text = moveTypeValue
			_bottomMenu.imageContainer.removeAllElements();
			var s:SpriteVisualElement = new SpriteVisualElement();
			s.addChild(pic);
			_bottomMenu.imageContainer.addElement(s);
			_bottomMenu.hp_bar.minimum = 0;
			_bottomMenu.hp_bar.label = "HP: "+ hp_akt +"/"+hp_max;
			_bottomMenu.hp_bar.setProgress(hp_akt,hp_max);
		}
	}
}