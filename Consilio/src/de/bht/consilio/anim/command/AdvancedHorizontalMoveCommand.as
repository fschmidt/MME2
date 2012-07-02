package de.bht.consilio.anim.command
{
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.board.Square;
	import de.bht.consilio.controller.GameController;
	import de.bht.consilio.controller.RemoteServiceController;
	import de.bht.consilio.event.ActionEvent;
	import de.bht.consilio.util.Constants;

	public class AdvancedHorizontalMoveCommand implements IMoveCommand
	{
		private var _piece:Piece;
		private var _canMoveBackwards:Boolean;
		
		public function AdvancedHorizontalMoveCommand(piece:Piece, canMoveBackwards:Boolean=true) {
			_piece = piece;
			_canMoveBackwards = canMoveBackwards;
		}
		
		public function execute() : void {
			activateAccessibleSquares();
		}
		
		public function cancel():void {
			GameController.getInstance().disableAllActions();
		}
		
		public function activateAccessibleSquares():void
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
			source.registeredPiece.addEventListener(ActionEvent.COMPLETE, function(e:ActionEvent):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				GameController.getInstance().endTurn();
				// send turn data to opponent
				var currentTurn:Object = new Object();
				currentTurn.action = "move";
				currentTurn.source = source.id;
				currentTurn.target = target.id;
				RemoteServiceController.getInstance().turn(currentTurn);
			});
			GameController.getInstance().disableAllActions();
			source.registeredPiece.moveTo(target);
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
				var next:String = getForwardAdjectedSquareId(last);
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
					next = getBackwardAdjectedSquareId(last);
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
					next = getLefthandAdjectedSquareId(last);
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
					next = getRighthandAdjectedSquareId(last);
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
		
		private function getForwardAdjectedSquareId(id:String):String
		{
			if(_piece.facing == "ne") {
				return id.charAt(0) + (parseInt(id.charAt(1)) + 1);
			}else{
				return id.charAt(0) + (parseInt(id.charAt(1)) - 1);
			}
		}
		
		private function getLefthandAdjectedSquareId(id:String):String
		{
			return String.fromCharCode(id.charCodeAt(0) - 1) + id.charAt(1);
		}
		
		private function getRighthandAdjectedSquareId(id:String):String
		{
			return String.fromCharCode(id.charCodeAt(0) + 1) + id.charAt(1);
		}
		
		private function getBackwardAdjectedSquareId(id:String):String
		{
			if(_piece.facing == "ne") {
				return id.charAt(0) + (parseInt(id.charAt(1)) - 1);
			}else{
				return id.charAt(0) + (parseInt(id.charAt(1)) + 1);
			}
		}
	}
}