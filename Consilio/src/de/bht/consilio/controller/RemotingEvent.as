package de.bht.consilio.controller
{
	import flash.events.Event;
	
	public class RemotingEvent extends Event
	{
		public static const GAME_MESSAGE_RECEIVED:String = "on game message received";
		public static const LOGIN_COMPLETE = "login complete";
		public static const LOGIN_FAILED = "login failed";
		
		private var _message:String;
		
		public function RemotingEvent(type:String, message:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_message = message;
		}
		
		public function get message():String
		{
			return _message;	
		}
	}
}