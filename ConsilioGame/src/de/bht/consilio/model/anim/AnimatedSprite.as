package de.bht.consilio.model.anim
{
	import de.bht.consilio.model.Board;
	import de.bht.consilio.util.ResourceLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.osflash.thunderbolt.Logger;
	
	public class AnimatedSprite extends Sprite
	{
		
		private var animations:Dictionary = new Dictionary();
		
		private var currentAnimation:Animation;
		
		private var spriteData:Object;
		
		public function AnimatedSprite(spriteDataUrl:String) 
		{
			init(spriteDataUrl);			
		}
		
		private function init(spriteDataUrl:String):void
		{
			var myRequest:URLRequest = new URLRequest(spriteDataUrl);
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
						locations.push(animationsToLoad[i].url + "000" + j + ".png");
					} else {
						locations.push(animationsToLoad[i].url + "00" + j + ".png");
					}
				}
				
				// write the loaded locations to the console
				for (var k:int = 0; k < locations.length; k++) 
				{
					Logger.log(Logger.INFO, "location:" + locations[k]);	
				}
				
				var key:String = animationsToLoad[i].name;
				
				Logger.log(Logger.INFO, "key:" + key);
				
				var data:Array = [animationsToLoad[i].animationdelay, animationsToLoad[i].frames];
				
				var loader:ResourceLoader = new ResourceLoader(key, data);
				loader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, function(e:Event):void {
					animationsLeftToLoad--
					Logger.log(Logger.INFO, "Animations left:" + animationsLeftToLoad);
					
					var loader:ResourceLoader = e.target as ResourceLoader;
					animations[loader.getKey()] = new Animation(loader.getLastResult(), loader.getData() as Array);
					if(animationsLeftToLoad < 1)
					{
						Logger.log(Logger.INFO, "no Animations left to load");
						// change this to stopped animation
						currentAnimation = animations["walking_ne"];
						dispatchEvent(new ConsilioEvent(ConsilioEvent.ON_INITIALIZATION_COMPLETE));
					}
				});
				
				loader.loadImages(locations);
			}
		}
		
		public function moveTo(target:String):void
		{
			currentAnimation = animations["walking_ne"];
			currentAnimation.start();
		}
		
		public function show():void
		{
			this.addChild(currentAnimation);
		}
		
		public function hide():void
		{
			this.removeChild(currentAnimation);
		}
	}
}