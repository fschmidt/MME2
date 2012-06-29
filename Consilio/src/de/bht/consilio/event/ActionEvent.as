package de.bht.consilio.event
{
	import flash.events.Event;
	
	public class ActionEvent extends Event
	{
		public static const COMPLETE:String = "action complete";
		
		public function ActionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}