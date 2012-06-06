package de.bht.consilio.anim.command
{
	import de.bht.consilio.board.Square;
	
	import flash.utils.Dictionary;
	
	public class HorizontalMovementType implements IMovementType
	{
		private const TYPE:String = "horizontal";
		private var _range:uint;
		private var _canMoveBackwards:Boolean;
		
		public function HorizontalMovementType(range:uint = 1, canMoveBackwards:Boolean = false)
		{
			_range = range;
			_canMoveBackwards = canMoveBackwards;
		}
		
		
		public function getAccessableSquares(position:String):Array
		{
			var result:Array = new Array();
			var last:String = position;
			for(var i:uint = 0; i<_range; i++)
			{
				var next:String = getForwardAdjectedSquareId(last);
				result.push(next);
				last = next;
			}
			
			if(_canMoveBackwards)
			{
				last = position;
				for(i = 0; i<_range; i++)
				{
					next = getBackwardAdjectedSquareId(last);
					result.push(next);
					last = next;
				}
			}
			return result;
		}
		
		public function getType():String
		{
			return TYPE;
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