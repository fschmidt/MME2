package de.bht.consilio.event
{
	import de.bht.consilio.board.Board;
	import de.bht.consilio.board.Square;
	
	import flash.events.Event;
	
	public class BoardEvent extends Event
	{
		public static const SQUARE_CLICKED:String = "square_clicked";
		
		private final var _board:Board;
		private final var _square:Square;
		
		public function BoardEvent(type:String, board:Board, square:Square, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_square = square;
			_board = board;
		}
		
		public function get square():Square
		{
			return _square;
		}
		
		public function get board():Board
		{
			return _board;
		}
	}
}