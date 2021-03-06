package de.bht.consilio.event
{
	import flash.events.Event;
	
	/**
	 * Consilio Event class
	 *  
	 * @author Frank Schmidt
	 * 
	 */
	public class ConsilioEvent extends Event
	{
		public static const ON_INITIALIZATION_COMPLETE:String = "initialization complete";
		
		public static const ON_RESOURCE_LOAD_COMPLETE:String = "resource load complete";
		
		public static const LOGIN:String = "login requested";
		
		public static const REGISTER:String = "login requested";
		
		private var _data:Object;
		

		public function ConsilioEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}
		
		public function get data():Object {
			return _data;
		}
	}
}