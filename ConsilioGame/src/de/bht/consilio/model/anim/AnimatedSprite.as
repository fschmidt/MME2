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
		
		private var animations:Dictionary;
		
		private var animationOffsetContainer:Sprite = new Sprite();
		
		public var currentAnimation:Animation;
		
		private var spriteData:Object;
		
		private var facing:String;
		
		public function AnimatedSprite(animations:Dictionary, xoffset:Number, yoffset:Number, size:Number, facing:String, currentAnimationName:String) 
		{
			super(size);
			this.animationOffsetContainer.x = -xoffset;
			this.animationOffsetContainer.y = -yoffset;
			this.facing = facing;
			this.name = name;
			this.animations = animations;
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		public function init(currentAnimationName:String):void {
			currentAnimation = animations[currentAnimationName];
			animationOffsetContainer.addChild(currentAnimation);
			addChild(animationOffsetContainer);
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