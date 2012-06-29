package de.bht.consilio.util
{
	import de.bht.consilio.anim.Attributes;
	import de.bht.consilio.anim.Piece;
	import de.bht.consilio.anim.command.AdvancedHorizontalMoveCommand;
	import de.bht.consilio.anim.command.AdvancedVerticalMoveCommand;
	import de.bht.consilio.anim.command.BasicHorizontalAttackCommand;
	import de.bht.consilio.anim.command.IAttackCommand;
	import de.bht.consilio.anim.command.IMoveCommand;
	import de.bht.consilio.anim.command.MoveCommandCombination;
	import de.bht.consilio.anim.command.ShootingAttackCommand;
	
	public class ActionCommandFactory
	{
		public function ActionCommandFactory()
		{
		}
		
		public static function moveCommandForAttributes(attributes:Attributes, piece:Piece):IMoveCommand {
			switch(attributes.movementType)
			{
				case Constants.MOVEMENT_TYPE_HORIZONTAL: {
					return new AdvancedHorizontalMoveCommand(piece, false);
				}
				case Constants.MOVEMENT_TYPE_VERTICAL: {
					return new AdvancedVerticalMoveCommand(piece, true);
				}
				case Constants.MOVEMENT_TYPE_HORIZONTAL_ADVANCED: {
					return new AdvancedHorizontalMoveCommand(piece, true);
				}
				case Constants.MOVEMENT_TYPE_BOTH: {
					return new MoveCommandCombination(new AdvancedHorizontalMoveCommand(piece, true), new AdvancedVerticalMoveCommand(piece, true));
				}
				default: 
					return new AdvancedHorizontalMoveCommand(piece, false);
			}
		}
		
		public static function attackCommandForAttributes(attributes:Attributes, piece:Piece):IAttackCommand {
			switch(attributes.movementType)
			{
				case Constants.ATTACK_TYPE_BASIC: {
					return new BasicHorizontalAttackCommand(piece);
				}
				case Constants.ATTACK_TYPE_SHOOTING: {
					return new ShootingAttackCommand(piece, attributes.attackRange);
				}
				case Constants.ATTACK_TYPE_MAGIC_SPELLING: {
					return new ShootingAttackCommand(piece, attributes.attackRange);
				}
				default: 
					return new BasicHorizontalAttackCommand(piece);
			}
		}
	}
}