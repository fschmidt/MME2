package de.bht.consilio.controller
{
	import flash.events.Event;
	
	public class RemotingEvent extends Event
	{
		public static const GAME_MESSAGE_RECEIVED:String = "on game message received";
		public static const CHAT_MESSAGE_RECEIVED:String = "on chat message received";
		public static const GAME_LIST_RECEIVED:String = "on game list received";
		public static const GAME_LIST_FAILED:String = "on game complete";
		public static const GAME_COMPLETE:String = "on game list failed";
		public static const GAME_FAILED:String = "on game failed";
		
		public static const LOGIN_COMPLETE:String = "login complete";
		public static const LOGIN_FAILED:String = "login failed";
		
		public static const REGISTRATION_COMPLETE:String = "registration complete";
		public static const REGISTRATION_FAILED:String = "registration failed";
		
		private var _message:String;
		private var _data:Object;
		
		public function RemotingEvent(type:String, message:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_message = message;
			_data = data;
		}
		
		public function get message():String
		{
			return _message;	
		}
		
		public function get data():Object
		{
			return _data;	
		}
	}
}