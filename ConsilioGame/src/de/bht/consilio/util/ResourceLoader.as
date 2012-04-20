package de.bht.consilio.util
{
	import de.bht.consilio.model.anim.ConsilioEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.thunderbolt.Logger;
	
	
	/**
	 * This class is responsible for loading external resources.
	 * 
	 * @author Frank
	 * 
	 */
	public class ResourceLoader extends EventDispatcher {
		
		private var urls:Array;

		private var key:String;
		
		private var data:Object;
		
		private var results:Array = new Array();
		
		public function ResourceLoader(key:String=null, data:Object=null) 
		{
			this.key = key;
			this.data = data;
		}
		
		/**
		 * 
		 * @param urlList An Array ot String containing the urls of the sources
		 * @return An Array of Bitmaps
		 * 
		 */
		public function loadImages(urlList:Array):void {
			
			this.urls = urlList;
			
			loadImage(urls);
			
		}
		
		private function loadImage(urlList:Array):void
		{
			var loader:Loader = new Loader();
			
			var url:String = urls.pop() as String;
			
//			Logger.log(Logger.INFO, "Loading URL:" + url.toString());
			
			
			var urlRequest:URLRequest = new URLRequest(url);
			
			loader.load(urlRequest);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
		}
		
		private function imageLoaded(e:Event):void
		{
				results.push(new Bitmap(e.target.content.bitmapData));
				if(urls.length > 0){
					loadImage(urls);
				} else {
					dispatchEvent(new ConsilioEvent(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE));
				}
		}
		
		public function getLastResult():Array
		{
			return results;
		}
		
		public function getKey():String
		{
			return key;
		}
		
		public function getData():Object
		{
			return data;
		}
	}
}