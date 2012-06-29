package de.bht.consilio.anim.command
{
	import de.bht.consilio.controller.GameController;

	public class MoveCommandCombination implements IMoveCommand
	{
		private var _command1:IMoveCommand;
		private var _command2:IMoveCommand;
		
		public function MoveCommandCombination(command1:IMoveCommand, command2:IMoveCommand)
		{
			_command1 = command1;
			_command2 = command2;
		}
		
		public function hasTarget():Boolean
		{
			return _command1.hasTarget() || _command2.hasTarget();
		}
		
		public function execute():void
		{
			if(_command1.hasTarget()) {
				_command1.execute();
			}
			if(_command2.hasTarget()) {
				_command2.execute();
			}
		}
		
		public function cancel():void
		{
			GameController.getInstance().disableAllActions();
		}
	}
}