package de.bht.consilio.board
{
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.anim.command.HorizontalMovementType;
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
		public function init(boardData:Object):void
		{
			var pieces:Array = boardData.pieces as Array;
			
			for (var i:int = 0; i < pieces.length; i++) {
				addPiece(pieces[i].name, pieces[i].position, pieces[i].facing);
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
		private function addPiece(name:String, position:String, facing:String):void 
		{
			var piece:Piece = new Piece(name, position, facing, isOwnPiece(position), new HorizontalMovementType());
			piece.position = getSquare(position).position;
			getSquare(position).registeredPiece = piece;
			getSquare(position).isOccupied = true;
						
			// enable onClick events for every square
//			if(piece.isOwnPiece) {
//				getSquare(position).addEventListener(MouseEvent.CLICK, onClick);
//			}
			addChild(piece);
		}
		
		/**
		 * @return true whether this piece is property of this player, false if its an opponents piece
		 * 
		 */
		private function isOwnPiece(position:String):Boolean
		{
			var rowNumber:String = position.charAt(1);
			return rowNumber.match("1") || rowNumber.match("2");
		}
		
		/**
		 * Handle mouse click on a square
		 * @param e the MouseEvent
		 * 
		 */
		private function onClick(e:MouseEvent):void
		{
			var s:Square = e.target as Square;
			if(s.registeredPiece)
			{
				//Charcodes are 97 - a to 104 - h
				trace("CharCode: " + s.id.charCodeAt(0));
				trace("Letter: " + s.id.charAt(0));
				if(!s.isSelected())
				{
					if(_selectedSquare != null)
					{
						_selectedSquare.setSelected(false);
						_selectedSquare.registeredPiece.stopCurrentAnimation();
						_selectedSquare.redraw(_selectedSquare.color);
						_selectedSquare.addEventListener(MouseEvent.CLICK, onClick);			
					}
					if (_target != null){
						_target.removeEventListener(MouseEvent.CLICK, move);
						_target.redraw(_target.color);
						_target.addEventListener(MouseEvent.CLICK, onClick);
						_target.removeEventListener(MouseEvent.CLICK, attack);
					}
					
					_selectedSquare = s;
					var current:AnimatedSprite = s.registeredPiece;
					current.startCurrentAnimation();
					s.redraw(_selected);
					
					var sp:Point = IsoUtils.isoToScreen(s.position);
					trace(s.id + ": " + sp);
					
					var sp2:Point = IsoUtils.isoToScreen(s.registeredPiece.position);
					trace("Piece: " + ": " + sp2);
					
					// test movement
					_target = getHorizontalAdjectedSquare(s, current.facing);
					if(_target.registeredPiece == null){
						var sqp:Point = IsoUtils.isoToScreen(_target.position);
						trace("Move: " + _target.id + ": " + sqp);
						_target.redraw(0x00ff00);
						s.removeEventListener(MouseEvent.CLICK, onClick);
						_target.addEventListener(MouseEvent.CLICK, move);
					} else if(s.registeredPiece.facing != _target.registeredPiece.facing){
						trace("attack: "+_selectedSquare+":"+_target);
						_target.redraw(0xff0000);
						s.removeEventListener(MouseEvent.CLICK, onClick);
						_target.removeEventListener(MouseEvent.CLICK, onClick);
						_target.addEventListener(MouseEvent.CLICK, attack);
					}
				}
			}
		}
		
		protected function attack(e:MouseEvent):void
		{
			_selectedSquare.registeredPiece.stopCurrentAnimation();
			_target.registeredPiece.livePoints--;
			
			//TODO remove Sprite
			
			_target.addEventListener(MouseEvent.CLICK, onClick);
			_target.removeEventListener(MouseEvent.CLICK, attack);
			_target.redraw(_target.color);
			
			_selectedSquare.redraw(_selectedSquare.color);
			_selectedSquare.addEventListener(MouseEvent.CLICK, onClick);
			
			_selectedSquare = null;
			_target = null;
		}
		
		private function move(e:Event):void 
		{			
			e.currentTarget.removeEventListener( e.type, arguments.callee );
			_selectedSquare.registeredPiece.moveTo(_target);
			_selectedSquare.registeredPiece.stopCurrentAnimation();
			_target.registeredPiece = _selectedSquare.registeredPiece;
			_target.addEventListener(MouseEvent.CLICK, onClick);
			_selectedSquare.registeredPiece = null;
			_target.redraw(_target.color);
			_selectedSquare.redraw(_selectedSquare.color);
			
			_selectedSquare = null;	
			_target = null;
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