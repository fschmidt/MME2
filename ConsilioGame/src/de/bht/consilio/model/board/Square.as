package de.bht.consilio.model.board
{
		import flash.display.*;
		import flash.events.*;
		import flash.utils.*;
		
		public class Square extends Sprite
		{
			private var _id:String;
			
			public function Square(color:uint)
			{ 
				var g:Graphics = this.graphics;
				g.beginFill(color);
				g.drawRect(0,0,60,60);
				g.endFill();
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