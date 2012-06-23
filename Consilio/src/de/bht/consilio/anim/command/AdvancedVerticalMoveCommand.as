package de.bht.consilio.anim.command
{
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.board.Square;
	import de.bht.consilio.controller.GameController;
	import de.bht.consilio.controller.RemoteServiceController;
	import de.bht.consilio.util.Constants;
	
	import flash.sampler.NewObjectSample;

	public class AdvancedVerticalMoveCommand implements IMoveCommand
	{
		private var _piece:Piece;
		private var _canMoveBackwards:Boolean;
		
		public function AdvancedVerticalMoveCommand(piece:Piece, canMoveBackwards:Boolean=true) {
			_piece = piece;
			_canMoveBackwards = canMoveBackwards;
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
			
			for(var i in res)
			{
				res[i].setClickAction(moveTo, GameController.getInstance().getSquareById(_piece.boardPosition));
				res[i].redraw(Constants.SQUARE_COLOR_EMPTY_TARGET);
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
			return getAccessableSquares(_piece.boardPosition).length > 0;
		}
		
		private function getAccessableSquares(position:String):Array
		{
			var result:Array = new Array();
			
			var last:String = position;
			for(var i:uint = 0; i<_piece.attributes.movement; i++)
			{
				var next:String = getForwardAdjectedSquareIdRightDiagonal(last);
				var s:Square = GameController.getInstance().getSquareById(next);
				if(s == null || s.isOccupied) {
					break;
				}
				result.push(s);
				last = next;
			}
			
			var last:String = position;
			for(var i:uint = 0; i<_piece.attributes.movement; i++)
			{
				var next:String = getForwardAdjectedSquareIdLeftDiagonal(last);
				var s:Square = GameController.getInstance().getSquareById(next);
				if(s == null || s.isOccupied) {
					break;
				}
				result.push(s);
				last = next;
			}
			
			if(_canMoveBackwards)
			{
				last = position;
				for(i = 0; i<_piece.attributes.movement; i++)
				{
					next = getBackwardAdjectedSquareIdRightDiagonal(last);
					var s:Square = GameController.getInstance().getSquareById(next);
					if(s == null || s.isOccupied) {
						break;
					}
					result.push(s);
					last = next;
				}
				
				last = position;
				for(i = 0; i<_piece.attributes.movement; i++)
				{
					next = getBackwardAdjectedSquareIdLeftDiagonal(last);
					var s:Square = GameController.getInstance().getSquareById(next);
					if(s == null || s.isOccupied) {
						break;
					}
					result.push(s);
					last = next;
				}
			}
			return result;
		}
		
		private function getForwardAdjectedSquareIdRightDiagonal(id:String):String
		{
			var newId:String = String.fromCharCode(id.charCodeAt(0) + 1) + (parseInt(id.charAt(1)) + 1);
			trace("New ID: " + newId);
			return newId;
		}
		
		private function getBackwardAdjectedSquareIdRightDiagonal(id:String):String
		{
			var newId:String = String.fromCharCode(id.charCodeAt(0) - 1) + (parseInt(id.charAt(1)) - 1);
			trace("New ID: " + newId);
			return newId;
		}
		
		private function getForwardAdjectedSquareIdLeftDiagonal(id:String):String
		{
			var newId:String = String.fromCharCode(id.charCodeAt(0) - 1) + (parseInt(id.charAt(1)) + 1);
			trace("New ID: " + newId);
			return newId;
		}
		
		private function getBackwardAdjectedSquareIdLeftDiagonal(id:String):String
		{
			var newId:String = String.fromCharCode(id.charCodeAt(0) + 1) + (parseInt(id.charAt(1)) - 1);
			trace("New ID: " + newId);
			return newId;
		}
	}
}