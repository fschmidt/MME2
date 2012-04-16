package de.bht.consilio.model.anim
{
	import de.bht.consilio.model.Board;
	import de.bht.consilio.util.ResourceLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.osflash.thunderbolt.Logger;
	
	public class AnimatedSpriteOld extends Sprite
	{
		protected var animationDelay:uint = 5;
		protected var animationIndex:uint = 0;
		
		protected var locations:Array;
		protected var textures:Array = new Array();
		protected var textureKeys:Array;
		
		protected var animationStart:uint;
		protected var animationEnd:uint;
		
		protected var currentFrame:Bitmap;
		protected var currentFrameIndex:uint = 0;
		
		protected var currentPosition:String;
		
		public function AnimatedSpriteOld() {
			super();
		}
		
		public function initialize():void 
		{
			Logger.log(Logger.INFO, "initializing");
			var loader:ResourceLoader = new ResourceLoader();
			loader.loadImages(locations);
			loader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, resourcesLoaded);
		}
		
		private function resourcesLoaded(e:Event):void 
		{
			
			var loader:ResourceLoader = e.target as ResourceLoader;
			textures = loader.getLastResult();
			Logger.log(Logger.INFO, "Textures len:" + textures.length);
			
			animationIndex = 0;
			animationStart = 0;
			animationEnd = 7;
			
			var tmp:Bitmap = (Bitmap)(textures[0]);
			
			currentFrame = new Bitmap();
			currentFrame.bitmapData = new BitmapData(tmp.width, tmp.height);
			
			currentFrame.bitmapData.copyPixels(tmp.bitmapData, new Rectangle(0,0,0), new Point(0, 0));
			
			attachMouseListener();
			
			dispatchEvent(new ConsilioEvent(ConsilioEvent.ON_INITIALIZATION_COMPLETE));
		}
		
		public function startAnimation(board:Board):void 
		{
			this.addChild(currentFrame);
			addEventListener(Event.ENTER_FRAME, animate);
		}
		
		private function attachMouseListener():void
		{
			this.addEventListener(MouseEvent.CLICK, attack);
		}
		
		private function attack(e:MouseEvent):void
		{
			animationIndex = 0;
			animationStart = 8;
			animationEnd = 17;
			currentFrameIndex = animationStart;
		}
		
		private function animate(e:Event):void 
		{
			animationIndex++;
			
			if(animationIndex >= animationDelay) {
				animationIndex = 0;
				
				if(currentFrameIndex >= animationEnd)
				{
					currentFrameIndex = animationStart;
				} 
				else 
				{
					currentFrameIndex++;
				}
				
				currentFrame.bitmapData.copyPixels(((Bitmap)(textures[currentFrameIndex])).bitmapData, currentFrame.bitmapData.rect, new Point(0, 0));
			}
		}
		
		public function getCurrentPosition():String
		{
			return currentPosition;
		}
		
		public function setCurrentPosition(newPosition:String):void
		{
			currentPosition = newPosition;
		}
		
	}
}