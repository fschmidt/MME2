package de.bht.consilio.anim.command
{
	import de.bht.consilio.command.ICommand;
	
	import flash.utils.Dictionary;

	public interface IMoveCommand extends ICommand
	{	
		function hasTarget():Boolean;
	}
}