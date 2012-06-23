package de.bht.consilio.anim.command
{
	public class NullAttackCommand implements IAttackCommand
	{
		public function NullAttackCommand()
		{
		}
		
		public function execute():void
		{
			trace("NullAttackCommand");
		}
		
		public function cancel():void
		{
			trace("NullAttackCommand");
		}
		
		public function hasTarget():Boolean {
			return false;
		}
	}
}