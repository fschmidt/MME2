package de.bht.consilio.anim.command
{
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.board.Square;
	import de.bht.consilio.controller.GameController;
	import de.bht.consilio.controller.RemoteServiceController;
	import de.bht.consilio.controller.RemotingEvent;
	import de.bht.consilio.util.Constants;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public  class BasicMoveCommand implements IMoveCommand
	{
		private var _piece:Piece;
		
		public function BasicMoveCommand(piece:Piece) {
			_piece = piece;
		}
		
		public function execute() : void {
			activateAccessibleSquares();
		}
		
		public function cancel():void {
			GameController.getInstance().disableAllActions();
		}
		
		private function activateAccessibleSquares():void
		{
			var res:Array = getAccessableSquares(_piece.boardPosition);
			
			trace("accessable squares");
			
			for(var i:String in res)
			{
				trace(i);
				var s:Square = (GameController.getInstance().squares[res[i]] as Square);
				if(!s.isOccupied)
				{
					trace("s not occupied");
					s.setClickAction(moveTo, GameController.getInstance().getSquareById(_piece.boardPosition));
					s.redraw(Constants.SQUARE_COLOR_EMPTY_TARGET);
				}
			}
		}
		
		private function moveTo(source:Square, target:Square):void
		{
			GameController.getInstance().disableAllActions();
			var currentTurn:Object = new Object();
			
			// send turn data to opponent
			currentTurn.action = "move";
			currentTurn.source = source.id;
			currentTurn.target = target.id;
			RemoteServiceController.getInstance().turn(currentTurn);
			
			source.registeredPiece.moveTo(target);
			target.registeredPiece = source.registeredPiece;
			target.makeSelectable(true);
			target.isOccupied = true;
			source.registeredPiece = null;
			source.isOccupied = false;
			target.redraw(target.color);
			source.redraw(source.color);
			source.makeSelectable(false);
		}
		
		public function hasTarget():Boolean {
			var res:Array = getAccessableSquares(_piece.boardPosition);
			for(var i:String in res)
			{
				var s:Square = (GameController.getInstance().squares[res[i]] as Square);
				if(!s.isOccupied)
				{
					return true;
				}
			}
			
			return false;
		}
		
		private function getAccessableSquares(position:String):Array
		{
			var result:Array = new Array();
			var last:String = position;
			for(var i:uint = 0; i<_piece.attributes.movement; i++)
			{
				var next:String = getForwardAdjectedSquareId(last);
				result.push(next);
				last = next;
			}
			
//			if(_canMoveBackwards)
//			{
//				last = position;
//				for(i = 0; i<_range; i++)
//				{
//					next = getBackwardAdjectedSquareId(last);
//					result.push(next);
//					last = next;
//				}
//			}
			return result;
		}
		
		private function getForwardAdjectedSquareId(id:String):String
		{
			return id.charAt(0) + (parseInt(id.charAt(1)) + 1);
			
		}
		
		private function getBackwardAdjectedSquareId(id:String):String
		{
			return id.charAt(0) + (parseInt(id.charAt(1)) - 1);
		}
	}
}