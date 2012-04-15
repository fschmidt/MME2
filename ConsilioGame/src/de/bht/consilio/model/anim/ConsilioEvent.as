package de.bht.consilio.model.anim
{
	import flash.events.Event;
	
	public class ConsilioEvent extends Event
	{
		public static const ON_INITIALIZATION_COMPLETE:String = "initialization complete";
		
		public static const ON_RESOURCE_LOAD_COMPLETE:String = "resource load complete";

		public function ConsilioEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}