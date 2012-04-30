package de.bht.consilio.util
{
	
	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.anim.Animation;
	import de.bht.consilio.model.anim.ConsilioEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import org.osflash.thunderbolt.Logger;

	public class AnimatedSpriteFactory extends EventDispatcher
	{
		public function createAnimatedSpriteFromJsonDescription(baseUrl:String, spriteData:Object, facing:String, boardPosition:String) : void {

			var name:String = spriteData.name;
			
			var animationsToLoad:Array = spriteData.animations as Array;
			var animationsLeftToLoad:uint = 0;
			var animations:Dictionary = new Dictionary();
			
			var result:AnimatedSprite = new AnimatedSprite(animations, 55, 65, 96, facing, boardPosition, "stopped");
			
			for (var i:int = 0; i < animationsToLoad.length; i++) {
				
				animationsLeftToLoad++;
				
				var locations:Array = new Array();

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
						result.init("walking " + facing);
						
						dispatchEvent(new AnimatedSpriteFactoryEvent(AnimatedSpriteFactoryEvent.ON_SPRITE_CLOAD_COMPLETE, result));
					}
				});
				
				loader.loadImages(locations);
			}
		}
	}
}