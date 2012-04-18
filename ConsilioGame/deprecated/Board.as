package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.anim.ConsilioEvent;
	import de.bht.consilio.util.ResourceLoader;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class Board extends MovieClip
	{
		
		private var fields:Dictionary;
		private var tileBlack:Bitmap;
		private var tileWhite:Bitmap;
		private var board:Bitmap;
		
		private var boardData:Object;
		
		public function Board()
		{
			super();
		}
		
		public function initialize():void{
			
			var myRequest:URLRequest = new URLRequest("img/background/board.json");
			var myLoader:URLLoader = new URLLoader();
			myLoader.addEventListener(Event.COMPLETE, onload);
			myLoader.load(myRequest);
			
		}
		
		private function onload(e:Event):void
		{
			boardData = JSON.parse(e.target.data);
			
			var loader:ResourceLoader = new ResourceLoader();
			
			var urlList:Array = ["img/boards/board.png"];
			
			loader.loadImages(urlList);
			
			loader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, resourcesLoaded);
		}
		
		private function resourcesLoaded(e:Event):void {
			
			var loader:ResourceLoader = e.target as ResourceLoader;
			
			board = loader.getLastResult()[0];
			
			addChild(board);
			
			dispatchEvent(new ConsilioEvent(ConsilioEvent.ON_INITIALIZATION_COMPLETE));
		}
		
		public function addSprite(sprite:AnimatedSprite):void
		{
			addChild(sprite);
		}
	}
}