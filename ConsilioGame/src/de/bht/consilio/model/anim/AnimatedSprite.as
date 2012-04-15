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
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.osflash.thunderbolt.Logger;
	
	public class AnimatedSprite extends Sprite
	{
		protected var animationDelay:uint = 5;
		protected var animationIndex:uint = 0;
		
		protected var locations:Array;
		protected var textures:Array = new Array();
		protected var textureKeys:Array;
		
		protected var currentAnimation:uint;
		protected var currentFrame:Bitmap;
		protected var currentFrameIndex:uint = 0;
		
		protected var currentPosition:String;
		
		public function AnimatedSprite() {
			super();
		}
		
		public function initialize():void 
		{
			Logger.log(Logger.INFO, locations.length+"");
			while(locations.length > 0)
			{
				var loader:ResourceLoader = new ResourceLoader();
				var tmp:Array = locations.pop();
				loader.loadImages(tmp);
				loader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, resourcesLoaded);
			}
		}
		
		private function resourcesLoaded(e:Event):void 
		{
			
			var loader:ResourceLoader = e.target as ResourceLoader;
			textures.push(loader.getLastResult());
			
			if(locations.length < 1){
				currentAnimation = 0;
				var tmp:Bitmap = (Bitmap)(textures[currentAnimation][0]);
				
				currentFrame = new Bitmap();
				currentFrame.bitmapData = new BitmapData(tmp.width, tmp.height);
				
				currentFrame.bitmapData.copyPixels(tmp.bitmapData, new Rectangle(0, tmp.width, tmp.height), new Point(0, 0));
				dispatchEvent(new ConsilioEvent(ConsilioEvent.ON_INITIALIZATION_COMPLETE));
			}
		}
		
		public function startAnimation(board:Board):void 
		{
			this.addChild(currentFrame);
			board.addSprite(this);
			addEventListener(Event.ENTER_FRAME, animate);
		}
		
		private function animate(e:Event):void 
		{
			animationIndex++;
			
			if(animationIndex >= animationDelay) {
				animationIndex = 0;
				
				Logger.log(Logger.INFO, "Frame Index before check: "+ currentFrameIndex);
				
				if(currentFrameIndex >= textures.length-1)
				{
					currentFrameIndex = 0;
				} 
				else 
				{
					currentFrameIndex++;
				}
				
				currentFrame.bitmapData.copyPixels(((Bitmap)(textures[currentAnimation][currentFrameIndex])).bitmapData, currentFrame.bitmapData.rect, new Point(0, 0));
			}
		}
		
		//		public function getCurrentFrame():Bitmap
		//		{
		//			return currentFrame;
		//		}
		
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