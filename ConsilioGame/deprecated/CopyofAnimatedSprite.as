package de.bht.consilio.model.anim
{
	import com.greensock.TweenLite;
	
	import de.bht.consilio.model.board.Square;
	import de.bht.consilio.model.iso.IsoObject;
	import de.bht.consilio.model.iso.IsoUtils;
	import de.bht.consilio.model.iso.Point3D;
	import de.bht.consilio.util.ResourceLoader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
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
			this.mouseEnabled = false;
			this.mouseChildren = false;
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
		
		public function moveTo(target:Square):void
		{
			var p3d:Point3D = target.position;
			var p:Point = IsoUtils.isoToScreen(p3d);
			TweenLite.to(this, 7, {x:p.x, y:p.y, onComplete : finishedWalking});
//			animationOffsetContainer.removeChild(currentAnimation);
//			currentAnimation = animations["walking " + target];
//			animationOffsetContainer.addChild(currentAnimation);
			currentAnimation.start();
		}
		private function finishedWalking(e:Event):void
		{
			pause();	
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
			animationOffsetContainer.addChild(currentAnimation);
		}
		
		public function hide():void
		{
			animationOffsetContainer.removeChild(currentAnimation);
		}
	}
}