package de.bht.consilio.board
{
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.application.ConsilioApplication;
	import de.bht.consilio.iso.IsoUtils;
	import de.bht.consilio.iso.Point3D;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.*;
	import flash.utils.*;
	
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
		private var squares:Dictionary = new Dictionary();
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
					
					square = new Square(60, color);
					square.position = new Point3D(c * 60, 0, r * 60);
					square.id = letter + number.toString();
					
					addChild(square);
					squares[square.id] = square;
				}
				
				number--;
			}
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
			var piece:AnimatedSprite = new AnimatedSprite(name, position, facing);
			piece.position = getSquare(position).position;
			getSquare(position).registeredSprite = piece;
			
			// enable onClick events for every square
			getSquare(position).addEventListener(MouseEvent.CLICK, onClick);
			addChild(piece);
		}
		
		/**
		 * Handle mouse click on a square
		 * @param e the MouseEvent
		 * 
		 */
		private function onClick(e:MouseEvent):void
		{
			var s:Square = e.target as Square;
			if(s.registeredSprite)
			{
				//Charcodes are 97 - a to 104 - h
				trace("CharCode: " + s.id.charCodeAt(0));
				trace("Letter: " + s.id.charAt(0));
				if(!s.isSelected())
				{
					if(_selectedSquare != null)
					{
						_selectedSquare.setSelected(false);
						_selectedSquare.registeredSprite.stopCurrentAnimation();
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
					var current:AnimatedSprite = s.registeredSprite;
					current.startCurrentAnimation();
					ConsilioApplication.getInstance().setMenuEntry(current.picture, 2, 2, 1, "diagonal",current.maxLivePoints,current.livePoints);
					s.redraw(_selected);
					
					var sp:Point = IsoUtils.isoToScreen(s.position);
					trace(s.id + ": " + sp);
					
					var sp2:Point = IsoUtils.isoToScreen(s.registeredSprite.position);
					trace("Piece: " + ": " + sp2);
					
					// test movement
					_target = getHorizontalAdjectedSquare(s, current.facing);
					if(_target.registeredSprite == null){
						var sqp:Point = IsoUtils.isoToScreen(_target.position);
						trace("Move: " + _target.id + ": " + sqp);
						_target.redraw(0x00ff00);
						s.removeEventListener(MouseEvent.CLICK, onClick);
						_target.addEventListener(MouseEvent.CLICK, move);
					} else if(s.registeredSprite.facing != _target.registeredSprite.facing){
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
			_selectedSquare.registeredSprite.stopCurrentAnimation();
			_target.registeredSprite.livePoints--;
			
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
			_selectedSquare.registeredSprite.moveTo(_target);
			_selectedSquare.registeredSprite.stopCurrentAnimation();
			_target.registeredSprite = _selectedSquare.registeredSprite;
			_target.addEventListener(MouseEvent.CLICK, onClick);
			_selectedSquare.registeredSprite = null;
			_target.redraw(_target.color);
			_selectedSquare.redraw(_selectedSquare.color);
			
			_selectedSquare = null;	
			_target = null;
		}
		
		private function getHorizontalAdjectedSquare(square:Square, direction:String):Square
		{
			if(direction=="ne")
			{
				return squares[square.id.charAt(0) + (parseInt(square.id.charAt(1)) + 1)];
				
			} else if (direction=="sw"){
				return squares[square.id.charAt(0) + (parseInt(square.id.charAt(1)) + -1)];
			} else {
				return null;
			}
			
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
			return squares[id] as Square;
		}
	}
}