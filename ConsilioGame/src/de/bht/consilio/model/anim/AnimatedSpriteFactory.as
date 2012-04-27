package de.bht.consilio.model.anim
{
	import de.bht.consilio.util.ResourceLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import org.osflash.thunderbolt.Logger;

	public class AnimatedSpriteFactory extends EventDispatcher
	{
		public function createAnimatedSpriteFromJsonDescription(baseUrl:String, spriteData:Object, facing:String) : AnimatedSprite{
			var name:String = spriteData.name;
			
			var animationsToLoad:Array = spriteData.animations as Array;
			var animationsLeftToLoad:uint = 0;
			
			var animations:Dictionary = new Dictionary();
			
			for (var i:int = 0; i < animationsToLoad.length; i++) {
				
				animationsLeftToLoad++;
				
				
				var locations:Array = new Array();
//				
//				for (var j:int = 0; j < animationsToLoad.length; j++) 
//				{
//					locations[j] = baseUrl + spriteData.name + "/" + (locations[j] as String);
//					Logger.log(Logger.INFO, locations[j] as String);
//				}
				
				
				
				
				for(var j:int = animationsToLoad[i].numberOfFrames-1; j >= 0; j--)
				{
					if(j<10){
						locations.push(baseUrl + spriteData.name + "/" + animationsToLoad[i].name + "000" + j + ".png");
						Logger.log(Logger.INFO, baseUrl + spriteData.name + "/" + animationsToLoad[i].name + "000" + j + ".png");
					} else {
						locations.push(baseUrl + spriteData.name + "/" + animationsToLoad[i].name + "00" + j + ".png");
					}
				}
				
				var key:String = animationsToLoad[i].name;
				
				var data:Array = [animationsToLoad[i].animationdelay, animationsToLoad[i].numberOfFrames];
				
				var loader:ResourceLoader = new ResourceLoader(key, data);
				loader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, function(e:Event):void {
					animationsLeftToLoad--
					
					var loader:ResourceLoader = e.target as ResourceLoader;
					animations[loader.getKey()] = new Animation(loader.getLastResult(), loader.getData() as Array);
					if(animationsLeftToLoad < 1)
					{
						Logger.log(Logger.INFO, "Resource load finished");
						dispatchEvent(new ConsilioEvent(ConsilioEvent.ON_INITIALIZATION_COMPLETE));
					}
				});
				
				loader.loadImages(locations);
			}
			var result:AnimatedSprite = new AnimatedSprite(animations, 55, 65, 96, facing, "stopped");
			return result;
		}
	}
}