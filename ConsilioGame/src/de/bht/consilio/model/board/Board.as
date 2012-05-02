package de.bht.consilio.model.board
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.iso.Point3D;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.sampler.StackFrame;
	import flash.text.*;
	import flash.utils.*;
	
	import org.osflash.thunderbolt.Logger;
	
	public class Board extends Sprite
	{
		private var squares:Dictionary = new Dictionary();
		private var pieces:Dictionary = new Dictionary();
		
		public function Board( dark:uint, light:uint )
		{
			var letters:Array = [ "a", "b", "c", "d", "e", "f", "g", "h" ];
			var number:int = letters.length;
			var letter:String;
			
			var square:Square;
			var col:int = 8;
			var row:int = 8;
			var color:uint;
			var isDark:Boolean = true;
			
			for (var r:int = 0; r < col; r++)
			{
				// toggle true false for the isDark Boolean
				isDark = ! isDark;
				
				for (var c:int = 0; c < row; c++)
				{
					// toggle true false for the isDark Boolean
					isDark = ! isDark;
					
					// next letter from the letters array
					letter = letters[c];
					
					// set the color based on the status of isDark Boolean (true or false)
					if (isDark)
					{
						color = dark;
					}
					else
					{
						color = light;
					}
					
					square = new Square(60, color);
					square.position = new Point3D(c * 60, 0, r * 60);
					square.id = letter + number.toString();
					square.addEventListener(MouseEvent.CLICK, onClick);
					addChild(square);
					squares[square.id] = square;
				}
				
				number--;
			}
		}
		
		public function init(boardData:Object):void
		{
			var pieces:Array = boardData.pieces as Array;
			
			for (var i:int = 0; i < pieces.length; i++) {
				addPiece(pieces[i].name, pieces[i].position, pieces[i].facing);
			}
		}
		
		private function addPiece(name:String, position:String, facing:String):void 
		{
			var piece:AnimatedSprite = new AnimatedSprite(name, position, facing);
			piece.position = getSquare(position).position;
			getSquare(position).registerSprite(piece);
			addChild(piece);
		}
		
		private function onClick(e:MouseEvent):void
		{
			var s:Square = e.target as Square;
			if(s.registeredSprite)
			{
				// temporary
//				Logger.log(Logger.INFO, "CharCode: " + str.charCodeAt(0));
				s.registeredSprite.startCurrentAnimation();	
			}
		}
		
		public function getSquare(id:String):Square
		{
			return squares[id] as Square;
		}
	}
}