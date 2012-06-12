package de.bht.consilio.controller
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.controls.HTML;
	
	public class RemoteServiceController extends EventDispatcher
	{
		private HTML _jsAdapter;
		
		public function RemoteServiceController(jsAdapter:HTML)
		{
			_jsAdapter = jsAdapter; 
		}
	}
}