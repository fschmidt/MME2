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
	import flash.net.URLRequest;
	
	import org.osflash.thunderbolt.Logger;
	
	public class AnimatedSprite extends Sprite
	{
		private var board:Board;
		protected var animationDelay:uint = 5;
		protected var animationIndex:uint = 0;
		protected var textures:Array =new Array();
		protected var currentFrame:Bitmap;
		protected var currentFrameIndex:uint = 0;
		protected var locations:Array = new Array();
		protected var currentPosition:String;
		
		public function AnimatedSprite()
		{
			super();
			
		}
		
		public function initialize():void
		{
			//Add all of our image URLs into the array
			for (var i:int = 0; i < 8; i++) 
			{
				locations.push("img/dwarf96/" + "running ne000" + i + ".png");
			}
			
			var loader:ResourceLoader = new ResourceLoader();
			loader.loadImages(locations);
			loader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, resourcesLoaded);
			
		}
		
		private function resourcesLoaded(e:Event):void
		{
			var loader:ResourceLoader = e.target as ResourceLoader;
			textures = loader.getLastResult();
			
			currentFrame = textures[0];
			
			dispatchEvent(new ConsilioEvent(ConsilioEvent.ON_INITIALIZATION_COMPLETE));
		}
		
		public function startAnimation(board:Board):void
		{
			this.board = board;
			this.board.addSprite(currentFrame);
			addEventListener(Event.ENTER_FRAME, animate);
		}
		
		private function animate(e:Event):void
		{
			animationIndex++;
			
			Logger.log(Logger.INFO, "Animating: " + currentFrame.name);
			
			if(animationIndex >= animationDelay) {
				animationIndex = 0;
				
//				Logger.log(Logger.INFO, "Frame Index before check: "+ currentFrameIndex);
				
				if(currentFrameIndex >= textures.length-1){
					currentFrameIndex = 0;
				} else {
					currentFrameIndex++;
				}
				
//				Logger.log(Logger.INFO, "Frame Index after check: "+ currentFrameIndex);
				
				board.removeChild(currentFrame);
				currentFrame = textures[currentFrameIndex];
				board.addSprite(currentFrame);
			}
		}
		
		public function getCurrentFrame():Bitmap
		{
			return currentFrame;
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