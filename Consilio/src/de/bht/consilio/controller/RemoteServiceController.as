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
				if(resp.name){
					dispatchEvent(new RemotingEvent(RemotingEvent.LOGIN_COMPLETE, resp.name as String));
				} else {
					dispatchEvent(new RemotingEvent(RemotingEvent.LOGIN_FAILED, "who knows"));
				}
			});
		}
		
		public function game(userId:String, create:Boolean, gameId:String = null)
		{
			_jsGameAdapter = new HTMLLoader();
			
			var request:URLRequest = new URLRequest(CONSILIO_SERVICE_URI + "game");
			
			var requestVars:URLVariables = new URLVariables();
			
			if(create) {
				requestVars["mode"] = "create";
			} else if (gameId){
				requestVars["mode"] = "join";
			} else {
				throw new Error("No Game ID passed upon joining a game");
			}
			requestVars["userId"] = userId;
			requestVars["gameId"] = gameId;
			
			request.data = requestVars;
			request.method = URLRequestMethod.POST;
			
			_jsGameAdapter.load(request);
			_jsGameAdapter.addEventListener(Event.COMPLETE, function(e:Event):void{
				e.target.window.onMessageReceived = onGameMessageReceived;
			});
		}
		
		private function onGameMessageReceived(msg):void
		{
			var message:Object = JSON.parse(msg);
			dispatchEvent(new RemotingEvent(RemotingEvent.GAME_MESSAGE_RECEIVED, msg));
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
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
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