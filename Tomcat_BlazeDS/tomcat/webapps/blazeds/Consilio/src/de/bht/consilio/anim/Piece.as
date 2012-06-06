package de.bht.consilio.anim
{
	import de.bht.consilio.anim.command.IMovementType;
	

	public class Piece extends AnimatedSprite
	{
		private var _isOwnPiece:Boolean
		private var _movementType:IMovementType;
		
		public function Piece(name:String, boardPosition:String, facing:String, isOwnPiece:Boolean, movementType:IMovementType)
		{
			super(name, boardPosition, facing);
			_isOwnPiece = isOwnPiece;
			_movementType = movementType;
		}
		
		public function get isOwnPiece():Boolean {
			return _isOwnPiece;
		}
		
		public function get movementType():IMovementType 
		{
			return _movementType;
		}
	}
}