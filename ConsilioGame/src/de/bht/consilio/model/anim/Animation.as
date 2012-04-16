package de.bht.consilio.model.anim
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Animation extends Sprite
	{
		private var animationIndex:uint;
		private var currentFrameIndex:uint;
		
		private var textures:Array;
		private var animationDelay:uint;
		private var numberOfFrames:uint;
		
		private var currentFrame:Bitmap;
		
		public function Animation(textures:Array, data:Array)
		{
			if(data.length != 2)
			{
				throw new Error("invalid number of animation parameters - should be 2");
			}
			
			this.textures = textures;
			this.animationDelay = data[0] as uint;
			this.numberOfFrames = data[1] as uint;
			init();
		}
		
		private function init():void
		{
			animationIndex = 0;
			currentFrameIndex = 0;
			
			var tmp:Bitmap = (Bitmap)(textures[0]);
			
			currentFrame = new Bitmap();
			currentFrame.bitmapData = new BitmapData(tmp.width, tmp.height);
			
			currentFrame.bitmapData.copyPixels(tmp.bitmapData, new Rectangle(0,0,0), new Point(0, 0));
			
			this.addChild(currentFrame);
		}
		
		public function start():void
		{
			addEventListener(Event.ENTER_FRAME, animate);
		}
		
		public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME, animate);
			animationIndex = 0;
			currentFrameIndex = 0;
		}
		
		private function animate(e:Event):void 
		{
			animationIndex++;
			
			if(animationIndex >= animationDelay) {
				animationIndex = 0;
				
				if(currentFrameIndex >= numberOfFrames)
				{
					currentFrameIndex = 0;
				} 
				else 
				{
					currentFrameIndex++;
				}
				
				currentFrame.bitmapData.copyPixels(((Bitmap)(textures[currentFrameIndex])).bitmapData, currentFrame.bitmapData.rect, new Point(0, 0));
			}
		}
	}
}