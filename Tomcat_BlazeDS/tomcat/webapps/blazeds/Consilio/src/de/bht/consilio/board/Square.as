package de.bht.consilio.board
{
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.iso.IsoObject;
	
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
		protected var _color:uint
		protected var _selected:Boolean;
		protected var _registeredSprite:AnimatedSprite;
		
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
			_selected = false;
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
		public function get registeredSprite():AnimatedSprite
		{
			return _registeredSprite;
		}
		
		public function set registeredSprite(value:AnimatedSprite):void
		{
			_registeredSprite = value;
		}
		
		public function get color():uint
		{
			return _color;			
		}
		
		public function setSelected(selected:Boolean):void
		{
			_selected = selected;
		}
		
		public function isSelected():Boolean
		{
			return _selected;
		}
	}
}