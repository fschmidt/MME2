package de.bht.consilio.anim.command
{
	import de.bht.consilio.command.ICommand;
	
	public interface IAttackCommand extends ICommand
	{
		function hasTarget():Boolean;
	}
}