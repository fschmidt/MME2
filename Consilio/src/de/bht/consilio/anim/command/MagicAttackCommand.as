package de.bht.consilio.anim.command
{
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.board.Square;
	import de.bht.consilio.controller.GameController;
	import de.bht.consilio.controller.RemoteServiceController;
	import de.bht.consilio.event.ActionEvent;
	import de.bht.consilio.util.Constants;
	
	
	/**
	 * 
	 * @author Frank Schmidt
	 * 
	 */
	public class MagicAttackCommand implements IAttackCommand
	{
		private var _piece:Piece;
		private var _range:uint;
		
		public function MagicAttackCommand(piece:Piece, range:uint)
		{
			_piece = piece;
			_range = range;
		}
		
		public function hasTarget():Boolean
		{
			return getTargets(_piece.boardPosition).length > 0;
		}
		
		public function execute():void
		{
			var targets:Array = getTargets(_piece.boardPosition);
			for(var i in targets) {
				var s:Square = targets[i] as Square;
				s.setClickAction(attack, GameController.getInstance().getSquareById(_piece.boardPosition));
				s.redraw(Constants.SQUARE_COLOR_HOSTILE_TARGET);
			}
		}
		
		public function cancel():void
		{
			GameController.getInstance().disableAllActions();
		}
		
		private function getTargets(position:String):Array
		{
			var ids:Array = new Array();
			
			for (var i:uint = _range; i > 2; i--){ 
				ids.push(getForwardTargetId(position, i), getForewardRightDiagonalTargetId(position, i), 
					getForwardLeftDiagonalTargetId(position, i), getBackwardTargetId(position, i),
					getBackwardRightDiagonalTargetId(position, i), getBackwardLeftDiagonalTargetId(position, i));
			}
			
			var result:Array = new Array();
			
			for(var j in ids) {
				var s:Square = GameController.getInstance().getSquareById(ids[j]);
				if(isValidTarget(s)) {
					result.push(s);
				}
				
			}

			return result;
		}
		
		private function isValidTarget(s:Square):Boolean {
			return s != null && s.isOccupied && !s.registeredPiece.isOwnPiece;
		}
		
		private function attack(source:Square, target:Square):void
		{
			GameController.getInstance().disableAllActions();
			
			target.registeredPiece.addEventListener(ActionEvent.COMPLETE, function(e:ActionEvent):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				GameController.getInstance().endTurn();
				// send turn data to opponent
				var currentTurn:Object = new Object();
				currentTurn.action = "attack";
				currentTurn.source = source.id;
				currentTurn.target = target.id;
				RemoteServiceController.getInstance().turn(currentTurn);
			});
			
			source.registeredPiece.attack(target.registeredPiece);
			target.redraw(target.color);
			source.redraw(source.color);
		}
		
		private function getForewardRightDiagonalTargetId(id:String, range:uint):String
		{
			var newId:String = String.fromCharCode(id.charCodeAt(0) + range) + (parseInt(id.charAt(1)) + range);
			trace("New ID: " + newId);
			return newId;
		}
		
		private function getBackwardRightDiagonalTargetId(id:String, range:uint):String
		{
			var newId:String = String.fromCharCode(id.charCodeAt(0) - range) + (parseInt(id.charAt(1)) - range);
			trace("New ID: " + newId);
			return newId;
		}
		
		private function getForwardLeftDiagonalTargetId(id:String, range:uint):String
		{
			var newId:String = String.fromCharCode(id.charCodeAt(0) - range) + (parseInt(id.charAt(1)) + range);
			trace("New ID: " + newId);
			return newId;
		}
		
		private function getBackwardLeftDiagonalTargetId(id:String, range:uint):String
		{
			var newId:String = String.fromCharCode(id.charCodeAt(0) + range) + (parseInt(id.charAt(1)) - range);
			trace("New ID: " + newId);
			return newId;
		}
		
		private function getForwardTargetId(id:String, range:uint):String
		{
			return id.charAt(0) + (parseInt(id.charAt(1)) + range);
			
		}
		
		private function getBackwardTargetId(id:String, range:uint):String
		{
			return id.charAt(0) + (parseInt(id.charAt(1)) - range);
		}
	}
}