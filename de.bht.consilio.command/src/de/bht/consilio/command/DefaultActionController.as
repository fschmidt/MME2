package de.bht.consilio.command
{
	
	public class DefaultActionController implements IActionController
	{
		public function DefaultActionController()
		{
		}
		
		public function move():void
		{
			trace("Default_Action_Controller: No Controller set.");
		}
		
		public function attack():void
		{
			trace("Default_Action_Controller: No Controller set.");
		}
		
		public function special_1():void
		{
			trace("Default_Action_Controller: No Controller set.");
		}
		
		public function special_2():void
		{
			trace("Default_Action_Controller: No Controller set.");
		}
		
		public function special_3():void
		{
			trace("Default_Action_Controller: No Controller set.");
		}
		
		public function special_4():void
		{
			trace("Default_Action_Controller: No Controller set.");
		}
		
		public function cancelLastCommand():void
		{
			trace("Default_Action_Controller: No Controller set.");
		}
		
		public function canMove():Boolean{return false};
		public function canAttack():Boolean{return false};
		
		public function hasSpecialAction_1():Boolean{return false};
		public function hasSpecialAction_2():Boolean{return false};
		public function hasSpecialAction_3():Boolean{return false};
		public function hasSpecialAction_4():Boolean{return false};
	}
}