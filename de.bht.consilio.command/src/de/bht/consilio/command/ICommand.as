package de.bht.consilio.command
{
	public interface ICommand
	{
		function execute():void;
		function cancel():void;
	}
}