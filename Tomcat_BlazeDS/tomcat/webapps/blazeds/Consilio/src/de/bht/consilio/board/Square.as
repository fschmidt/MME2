package de.bht.consilio.board
{
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.iso.IsoObject;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class Square extends IsoObject
	{
		protected var _height:Number;
		protected var _id:String;
		protected var _color:uint
		
		protected var _registeredSprite:AnimatedSprite;
		
		public function Square(size:Number, color:uint)
		{ 
			super(size);
			_height = height;
			_color = color;
			
			draw();
		}
		
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
		
		public function registerSprite(value:AnimatedSprite):void
		{
			_registeredSprite = value;
		}
		
		public function get registeredSprite():AnimatedSprite
		{
			return _registeredSprite;
		}
	}
}