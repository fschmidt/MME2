package de.bht.consilio.controller
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.html.HTMLLoader;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.controls.HTML;
	
	public class RemoteServiceController extends EventDispatcher
	{
		public static const CONSILIO_SERVICE_URI:String = "http://consilio-game.appspot.com/";
		
		private static var instance:RemoteServiceController;
		
		private var _jsGameAdapter:HTMLLoader;
		
		private var _userId:String;
		
		private var _gameKey:String;
		
		public function RemoteServiceController(p_key:SingletonBlocker){
			if (p_key == null) {
				throw new Error("Error: Instantiation failed: Use Singleton.getInstance() instead of new.");
			} 
		}
		
		public static function getInstance():RemoteServiceController {
			if (instance == null) {
				instance = new RemoteServiceController(new SingletonBlocker());
			}
			return instance;
		}
		
		public function login(username:String, password:String):void {
			var account:Object = new Object();
			account.name = username;
			account.password = password;
			
			var requestVars:URLVariables = new URLVariables();
			
			requestVars["mode"] = "login";
			requestVars["account"] = JSON.stringify(account);
			
			callRemoteService("account", requestVars, function(e:Event):void {
				var loader:URLLoader = URLLoader(e.target);
				var resp:Object = JSON.parse(e.target.data);
				trace(resp.toString());
				if(resp.success == true){
					trace(resp.data.name as String);
					_userId = resp.data.name as String;
					dispatchEvent(new RemotingEvent(RemotingEvent.LOGIN_COMPLETE, resp.data.name as String));
				} else {
					dispatchEvent(new RemotingEvent(RemotingEvent.LOGIN_FAILED, resp.message));
				}
			});
		}
		
		public function register(username:String,  password:String, email:String):void {
			var account:Object = new Object();
			account.name = username;
			account.password = password;
			account.email = email;
			
			var requestVars:URLVariables = new URLVariables();
			
			requestVars["mode"] = "register";
			requestVars["account"] = JSON.stringify(account);
			
			callRemoteService("account", requestVars, function(e:Event):void {
				var loader:URLLoader = URLLoader(e.target);
				var resp:Object = JSON.parse(e.target.data);
				trace(resp.toString());
				if(resp.success == true){
					trace(resp.data.name as String);
					dispatchEvent(new RemotingEvent(RemotingEvent.REGISTRATION_COMPLETE, resp.data.name as String));
				} else {
					dispatchEvent(new RemotingEvent(RemotingEvent.REGISTRATION_FAILED, resp.message));
				}
			});
		}
		
		public function game(create:Boolean, gameId:String = null, gameKey:String = null) : void
		{
			_jsGameAdapter = new HTMLLoader();
			
			var request:URLRequest = new URLRequest(CONSILIO_SERVICE_URI + "game");
			
			var requestVars:URLVariables = new URLVariables();
			
			if(create) {
				requestVars["mode"] = "create";
				requestVars["gameId"] = gameId;
			} else if (gameKey){
				requestVars["mode"] = "join";
				requestVars["gameKey"] = gameKey;
			} else {
				throw new Error("No Game ID passed upon joining a game");
			}
			requestVars["userId"] = _userId;
			
			request.data = requestVars;
			request.method = URLRequestMethod.POST;
			
			_jsGameAdapter.load(request);
			_jsGameAdapter.addEventListener(Event.COMPLETE, function(e:Event):void {
				e.target.window.onMessageReceived = onGameMessageReceived;
				_gameKey = e.target.window.gameId;
				trace("Game ID from JSAdapter: " + e.target.window.gameId);
				dispatchEvent(new RemotingEvent(RemotingEvent.GAME_COMPLETE, null));
			});
		}
		
		public function getAllPublicGames():void
		{
			
			var requestVars:URLVariables = new URLVariables();
			
			requestVars["mode"] = "list";

			callRemoteService("game", requestVars, function(e:Event):void {
				var loader:URLLoader = URLLoader(e.target);
				var resp:Object = JSON.parse(e.target.data);
				trace(resp.toString());
				if(resp.success == true){
					dispatchEvent(new RemotingEvent(RemotingEvent.GAME_LIST_RECEIVED, "list", resp.data));
				} else {
					dispatchEvent(new RemotingEvent(RemotingEvent.GAME_LIST_FAILED, resp.message));
				}
			});
		}
		
		public function send(message:String):void {
			var chatMessage:Object = new Object();
			chatMessage.userId = _userId;
			chatMessage.gameId = _gameKey;
			chatMessage.type = "private";
			chatMessage.message = message;
			
			
			var url:String = CONSILIO_SERVICE_URI + "message";
			var request:URLRequest = new URLRequest(url);
			var requestVariables:URLVariables = new URLVariables();
			requestVariables["params"] = JSON.stringify(chatMessage);
			request.data = requestVariables;
			request.method = URLRequestMethod.POST;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			try {
				urlLoader.load(request);
			} catch (e:Error) {
				trace(e);
			}
		}
		
		private function onGameMessageReceived(msg):void
		{
//			var message:Object = JSON.parse(msg);
//			if(message.type == "public") {
//				
//			}
				dispatchEvent(new RemotingEvent(RemotingEvent.CHAT_MESSAGE_RECEIVED, msg));
		}
		
		private function callRemoteService(service:String, requestVariables:URLVariables, handler:Function):void
		{
			var url:String = CONSILIO_SERVICE_URI + service;
			var request:URLRequest = new URLRequest(url);
			
			request.data = requestVariables;
			request.method = URLRequestMethod.POST;
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, handler);
//			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			for (var prop:String in requestVariables) {
				trace("Sent: " + prop + " is: " + requestVariables[prop]);
			}
			try {
				urlLoader.load(request);
			} catch (e:Error) {
				trace(e);
			}
		}
		
		private function httpStatusHandler( e:HTTPStatusEvent ):void {
			trace("httpStatusHandler:" + e);
		}
		private function securityErrorHandler( e:SecurityErrorEvent ):void {
			trace("securityErrorHandler:" + e);
		}
		private function ioErrorHandler( e:IOErrorEvent ):void {
			trace("ORNLoader:ioErrorHandler: " + e);
		}
	}
}
internal class SingletonBlocker {}