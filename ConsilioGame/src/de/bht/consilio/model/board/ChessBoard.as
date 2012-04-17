package de.bht.consilio.model.board
{
		import flash.display.*;
		import flash.events.*;
		import flash.text.*;
		import flash.utils.*;
		
		import org.osflash.thunderbolt.Logger;
		
		public class ChessBoard extends Sprite
		{
			public function ChessBoard( dark:uint, light:uint )
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
						
						// create an instance of the Square class; pass in the current color
						square = new Square(color);
						square.x = square.width * c;
						square.y = square.height * r;
						
						// assign a value to the id property of square: number + letter
						square.id = letter + number.toString();
						square.addEventListener(MouseEvent.CLICK, onClick);
						addChild(square);
					}
					
					number--;
				}
			}
			
			private function onClick(e:MouseEvent):void
			{
				Logger.log(Logger.INFO, e.target.id);
			}
		}
	}