package de.bht.consilio.model.anim
{
	import de.bht.consilio.model.Board;
	import de.bht.consilio.model.iso.IsoObject;
	import de.bht.consilio.util.ResourceLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.osflash.thunderbolt.Logger;
	
	public class AnimatedSprite extends IsoObject
	{
		
		private var baseUrl:String;
		
		private var animations:Dictionary = new Dictionary();
		
		private var animationOffsetContainer:Sprite = new Sprite();
		
		private var currentAnimation:Animation;
		
		private var spriteData:Object;
		
		private var facing:String;
		
		public function AnimatedSprite(size:Number, xoffset:Number, yoffset:Number, baseUrl:String, spriteDataUrl:String, facing:String) 
		{
			super(size);
			this.animationOffsetContainer.x = -xoffset;
			this.animationOffsetContainer.y = -yoffset;
			this.facing = facing;
			this.baseUrl = baseUrl;
			init(baseUrl, spriteDataUrl);			
		}
		
		private function init(baseUrl:String, spriteDataUrl:String):void
		{
			var myRequest:URLRequest = new URLRequest(baseUrl + spriteDataUrl);
			var myLoader:URLLoader = new URLLoader();
			myLoader.addEventListener(Event.COMPLETE, onload);
			myLoader.load(myRequest);
		}
		
		private function onload(e:Event):void
		{
			spriteData = JSON.parse(e.target.data);
			var animationsToLoad:Array = spriteData.animations as Array;
			var animationsLeftToLoad:uint = 0;
			
			for (var i:int = 0; i < animationsToLoad.length; i++) 
			{
				
				animationsLeftToLoad++;
				
				var locations:Array = new Array();
				
				for(var j:int = animationsToLoad[i].frames-1; j >= 0; j--)
				{
					if(j<10){
						locations.push(baseUrl + animationsToLoad[i].name + "000" + j + ".png");
					} else {
						locations.push(baseUrl + animationsToLoad[i].name + "00" + j + ".png");
					}
				}
				
				// write the loaded locations to the console
				//				for (var k:int = 0; k < locations.length; k++) 
				//				{
				//					Logger.log(Logger.INFO, "location:" + locations[k]);	
				//				}
				
				var key:String = animationsToLoad[i].name;
				
				var data:Array = [animationsToLoad[i].animationdelay, animationsToLoad[i].frames];
				
				var loader:ResourceLoader = new ResourceLoader(key, data);
				loader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, function(e:Event):void {
					animationsLeftToLoad--
					
					var loader:ResourceLoader = e.target as ResourceLoader;
					animations[loader.getKey()] = new Animation(loader.getLastResult(), loader.getData() as Array);
					if(animationsLeftToLoad < 1)
					{
						// change this to stopped animation
						currentAnimation = animations["walking " + facing];
						animationOffsetContainer.addChild(currentAnimation);
						addChild(animationOffsetContainer);
						dispatchEvent(new ConsilioEvent(ConsilioEvent.ON_INITIALIZATION_COMPLETE));
					}
				});
				
				loader.loadImages(locations);
			}
		}
		
		public function moveTo(target:String):void
		{
			animationOffsetContainer.removeChild(currentAnimation);
			currentAnimation = animations["walking " + target];
			animationOffsetContainer.addChild(currentAnimation);
			currentAnimation.start();
		}
		
		public function attack(direction:String):void
		{
			animationOffsetContainer.removeChild(currentAnimation);
			currentAnimation = animations["attack " + direction];
			animationOffsetContainer.addChild(currentAnimation);
			currentAnimation.start();
		}
		
		public function stop():void
		{
			currentAnimation.stop();
		}
		
		public function start():void
		{
			currentAnimation.start();
		}
		
		public function pause():void
		{
			currentAnimation.pause();
		}
		
		public function show():void
		{
			animationOffsetContainer..addChild(currentAnimation);
		}
		
		public function hide():void
		{
			animationOffsetContainer..removeChild(currentAnimation);
		}
	}
}