package de.bht.consilio.anim.command
{
	public class NullSpecialCommand implements ISpecialCommand
	{
		public function NullSpecialCommand()
		{
		}
		
		public function execute():void
		{
			trace("NullSpecialCommand");
		}
		
		public function cancel():void
		{
			trace("NullSpecialCommand");
		}
		
		public function hasTarget():Boolean {
			return false;
		}
	}
}