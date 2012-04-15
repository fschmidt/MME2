package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.anim.ConsilioEvent;
	import de.bht.consilio.util.ResourceLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.osflash.thunderbolt.Logger;
	
	public class Board extends Sprite
	{
		
		private var fields:Dictionary;
		private var tileBlack:Bitmap;
		private var tileWhite:Bitmap;
		
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
			
			var urlList:Array = ["img/background/" + boardData.images.black, "img/background/" + boardData.images.white];
			
			loader.loadImages(urlList);
			
			loader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, resourcesLoaded);
		}
		
		private function resourcesLoaded(e:Event):void {
			
			fields = new Dictionary();
			
			var loader:ResourceLoader = e.target as ResourceLoader;
			
			tileBlack = loader.getLastResult()[0];
			tileWhite = loader.getLastResult()[1];
			
			var lastX:int = boardData.h_offset.x * 6;
			var lastY:int = 0 - boardData.h_offset.y;
			
			for (var i:int = 8; i > 0; i--) 
			{
				var tmp:Bitmap = i % 2 == 0 ? new Bitmap(tileWhite.bitmapData) : new Bitmap(tileBlack.bitmapData);
				tmp.x = lastX + boardData.h_offset.x;
				tmp.y = lastY + boardData.h_offset.y;
				fields["a" + i] = tmp;
				addChild(tmp);
			}
			
			lastX = boardData.h_offset.x * 6;
			lastY = boardData.v_offset.y - boardData.h_offset.y;
			
			for (var j:int = 8; i > 0; i--) 
			{
				tmp = i % 2 == 1 ? new Bitmap(tileWhite.bitmapData) : new Bitmap(tileBlack.bitmapData);
				tmp.x = lastX + boardData.h_offset.x;
				tmp.y = lastY + boardData.h_offset.y;
				fields["b" + j] = tmp;
				addChild(tmp);
			}
			
			
			dispatchEvent(new ConsilioEvent(ConsilioEvent.ON_INITIALIZATION_COMPLETE));
		}
		
		//		private function image2Loaded(e:Event):void {
		//			
		//			tileWhite = new Bitmap(e.target.content.bitmapData);
		//			
		//			tileBlack.x = boardData.A8.x;
		//			tileBlack.y = boardData.A8.y;
		//			
		//			tileWhite.x = boardData.A7.x;
		//			tileWhite.y = boardData.A7.y;
		//			
		//			addChild(tileBlack);
		//			addChild(tileWhite);
		//			
		//			var ice:ConsilioEvent = new ConsilioEvent(ConsilioEvent.ON_INITIALIZATION_COMPLETE);
		//			dispatchEvent(ice);
		//		}
		
		public function addSprite(sprite:Bitmap):void
		{
			sprite.x = (fields["a1"] as Bitmap).x+sprite.width/2;
			sprite.y = (fields["a1"] as Bitmap).y+sprite.height/2;
			addChild(sprite);
		}
	}
}