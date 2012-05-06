package de.bht.consilio.board
{
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.iso.IsoObject;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
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
			
			draw();
		}
		
		/**
		 * draws the square
		 */
		protected function draw():void
		{
			graphics.clear();
			graphics.beginFill(_color);
			graphics.moveTo(-size, 0);
			graphics.lineTo(0, -size * .5);
			graphics.lineTo(size, 0);
			graphics.lineTo(0, size * .5);
			graphics.lineTo(-size, 0);
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
		 * registers an AnimatedSprite on this square
		 * 
		 * @param value the sprite to register
		 * 
		 */
		public function registerSprite(value:AnimatedSprite):void
		{
			_registeredSprite = value;
		}
		
		/**
		 * @return the AnimatedSprite registered on this Square 
		 * 
		 */
		public function get registeredSprite():AnimatedSprite
		{
			return _registeredSprite;
		}
	}
}