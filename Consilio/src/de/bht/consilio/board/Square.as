package de.bht.consilio.board
{
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.controller.GameController;
	import de.bht.consilio.iso.IsoObject;
	import de.bht.consilio.util.Constants;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import flashx.textLayout.events.SelectionEvent;
	
	/**
	 * Class representing an isometric square on a chessboard
	 * 
	 * @author Frank Schmidt
	 * 
	 */
	public class Square extends IsoObject
	{
		protected var _height:Number;
		protected var _id:String;
		protected var _color:uint;
		protected var _isOccupied:Boolean;
		protected var _registeredPiece:Piece;
		
		private var clickAction:Function;
		
		/**
		 * Constructor
		 * 
		 * @param size size of the square
		 * @param color color of the square
		 * 
		 */
		public function Square(size:Number, color:uint)
		{ 
			super(size);
			_height = height;
			_color = color;
			draw(_color);
		}
		
		/**
		 * draws the square
		 */
		protected function draw(color:uint):void
		{
			graphics.clear();
			graphics.beginFill(color);
			graphics.moveTo(-size, 0);
			graphics.lineTo(0, -size * .5);
			graphics.lineTo(size, 0);
			graphics.lineTo(0, size * .5);
			graphics.lineTo(-size, 0);
		}
		
		public function makeSelectable(selectable:Boolean):void {
			if(selectable) {
				this.addEventListener(MouseEvent.CLICK, onSquareClick);
			} else {
				this.removeEventListener(MouseEvent.CLICK, onSquareClick);
			}
		}
		
		private function onSquareClick(e:Event):void
		{
			trace("clicked on selectable square");
			
			GameController.getInstance().disableSelections();
			
			GameController.getInstance().setMenuEntry(_registeredPiece);
			this.redraw(Constants.SQUARE_COLOR_SELECTED);
			this.registeredPiece.startCurrentAnimation();
			if(GameController.getInstance().isOwnTurn && _registeredPiece.isOwnPiece) {
				GameController.getInstance().attachActionMenu(this);
			}
		}
		
		public function setClickAction(f:Function, source:Object):void {
			clickAction = function(e:Event):void {
				f(source, e.target);
			};
			this.addEventListener(MouseEvent.CLICK, clickAction);
		}
		
		public function removeCurrentClickAction():void {
			if(clickAction != null) {
				this.removeEventListener(MouseEvent.CLICK, clickAction);
			}
		}
		
		public function redraw(color:uint):void
		{
			draw(color);
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id  = value;
		}
		
		/**
		 * @return the AnimatedSprite registered on this Square 
		 * 
		 */
		public function get registeredPiece():Piece
		{
			return _registeredPiece;
		}
		
		public function set registeredPiece(value:Piece):void
		{
			_registeredPiece = value;
			if(_registeredPiece) {
				_registeredPiece.boardPosition = this.id;
			}
		}
		
		public function get color():uint
		{
			return _color;			
		}
		
		public function set isOccupied(isOccupied:Boolean):void
		{
			_isOccupied = isOccupied;
		}
		
		public function get isOccupied():Boolean
		{
			return _isOccupied;
		}
	}
}