package de.bht.consilio.anim.command
{
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.board.Square;
	import de.bht.consilio.controller.GameController;
	import de.bht.consilio.controller.RemoteServiceController;
	import de.bht.consilio.util.Constants;

	public class BasicHorizontalAttackCommand implements IAttackCommand
	{
		private var _piece:Piece;
		
		public function BasicHorizontalAttackCommand(piece:Piece)
		{
			_piece = piece;
		}
		
		public function hasTarget():Boolean
		{
			return (GameController.getInstance().squares[getForwardAdjectedSquareId(_piece.boardPosition)] as Square).isOccupied;
		}
		
		public function execute():void
		{
			var s:Square = (GameController.getInstance().squares[getForwardAdjectedSquareId(_piece.boardPosition)] as Square);
			s.setClickAction(attack, GameController.getInstance().getSquareById(_piece.boardPosition));
			s.redraw(Constants.SQUARE_COLOR_HOSTILE_TARGET);
		}
		
		public function cancel():void
		{
			GameController.getInstance().disableAllActions();
		}
		
		private function attack(source:Square, target:Square):void
		{
			GameController.getInstance().disableAllActions();
			var currentTurn:Object = new Object();
			
			// send turn data to opponent
			currentTurn.action = "attack";
			currentTurn.source = source.id;
			currentTurn.target = target.id;
			RemoteServiceController.getInstance().turn(currentTurn);
			
			source.registeredPiece.attack(target.registeredPiece);
			target.redraw(target.color);
			source.redraw(source.color);
		}
		
		private function getForwardAdjectedSquareId(id:String):String
		{
			return id.charAt(0) + (parseInt(id.charAt(1)) + 1);
		}
	}
}