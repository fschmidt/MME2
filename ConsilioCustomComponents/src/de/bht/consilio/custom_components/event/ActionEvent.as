package de.bht.consilio.custom_components.event
{
	import flash.events.Event;
	
	public class ActionEvent extends Event
	{
		
		public static const MOVE_ACTION:String = "move action";
		public static const ATTACK_ACTION:String = "attack action";
		public static const SPECIAL_ACTION_1:String = "special action 1";
		
		public function ActionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}