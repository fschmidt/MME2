package de.bht.consilio.board
{
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.anim.Attributes;
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.anim.command.ActionController;
	import de.bht.consilio.anim.command.BasicMoveCommand;
	import de.bht.consilio.anim.command.NullAttackCommand;
	import de.bht.consilio.anim.command.NullSpecialCommand;
	import de.bht.consilio.application.ConsilioApplication;
	import de.bht.consilio.iso.IsoUtils;
	import de.bht.consilio.iso.Point3D;
	import de.bht.consilio.util.Constants;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.*;
	import flash.utils.*;
	
	import org.osmf.logging.Logger;
	
	/**
	 * Class representing a basic chessboard
	 * 
	 * @author Frank Schmidt
	 * 
	 */
	public class Board extends Sprite
	{
		/**
		 * dictionary containing the squares. a square can be accessed in chess notation (ie "a1")
		 */
		private var _squares:Dictionary = new Dictionary();
		private var _dark:uint;
		private var _light:uint;
		private var _selected:uint = 0x0000ff;
		private var _selectedSquare:Square;
		private var _target:Square;
		
		/**
		 * Creates a Chessboard
		 * 
		 * @param dark color value for the dark squares
		 * @param light color value for the light squares
		 * 
		 */
		public function Board( dark:uint, light:uint )
		{
			_dark = dark;
			_light = light;
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
					
					square = new Square(Constants.SQUARE_DEFAULT_SIZE, color);
					square.position = new Point3D(c * Constants.SQUARE_DEFAULT_SIZE, 0, r * Constants.SQUARE_DEFAULT_SIZE);
					square.id = letter + number.toString();
					
					addChild(square);
					_squares[square.id] = square;
				}
				
				number--;
			}
			
			this.x = Constants.BOARD_DEFAULT_POSITION_X;
			this.y = Constants.BOARD_DEFAULT_POSITION_Y;
		}
		
		/**
		 * Initialize this board with the given boardData
		 * 
		 * @param boardData dynamic json object containing the data for the setup used (all the pieces and their initial position)
		 * 
		 */
		public function init(boardData:Object, isWhitePlayer:Boolean):void
		{
			var pieces:Array = boardData.pieces as Array;
			
			for (var i:int = 0; i < pieces.length; i++) {
				addPiece(pieces[i].name, pieces[i].position, pieces[i].facing, isWhitePlayer);
			}
		}
		
		/**
		 * adds a piece to this board
		 * 
		 * @param name name of the piece
		 * @param position the pieces initial position on the board
		 * @param facing the direction the piece is facing
		 * 
		 */
		private function addPiece(name:String, position:String, facing:String, isWhitePlayer:Boolean):void 
		{
			//tmp
			var piece:Piece = new Piece(name, position, facing, isOwnPiece(position, isWhitePlayer), Attributes.newAttributesForPiece(name));
			piece.position = getSquare(position).position;
			getSquare(position).registeredPiece = piece;
			getSquare(position).isOccupied = true;
						
			addChild(piece);
		}
		
		/**
		 * @return true whether this piece is property of this player, false if its an opponents piece
		 * 
		 */
		private function isOwnPiece(position:String, isWhitePlayer:Boolean):Boolean
		{
			var rowNumber:String = position.charAt(1);
			if(isWhitePlayer) {
				return rowNumber.match("1") || rowNumber.match("2");
			} else {
				return rowNumber.match("7") || rowNumber.match("8");
			}
		}
		
		private function getHorizontalAdjectedSquare(square:Square, direction:String):Square
		{
			if(direction=="ne")
			{
				return _squares[square.id.charAt(0) + (parseInt(square.id.charAt(1)) + 1)];
				
			} else if (direction=="sw"){
				return _squares[square.id.charAt(0) + (parseInt(square.id.charAt(1)) + -1)];
			} else {
				return null;
			}
			
		}
		
		public function get squares():Dictionary {
			return _squares;
		}
		
		/**
		 * returns the square with the given id
		 * 
		 * @param id the squares id (ie "a1")
		 * @return 
		 * 
		 */
		public function getSquare(id:String):Square
		{
			return _squares[id] as Square;
		}
	}
}