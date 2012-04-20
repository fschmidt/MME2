package de.bht.consilio.model.board
{
	import de.bht.consilio.model.iso.IsoObject;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class Square extends IsoObject
	{
		protected var _height:Number;
		protected var _id:String;
		protected var _color:uint
		
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
	}
}