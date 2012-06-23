package de.bht.consilio.anim.command
{
	import de.bht.consilio.command.ICommand;
	
	public interface ISpecialCommand extends ICommand
	{
		function hasTarget():Boolean;
	}
}