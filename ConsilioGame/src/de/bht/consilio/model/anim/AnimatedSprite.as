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
	
	import org.osmf.net.StreamingURLResource;
	
	public class AnimatedSprite extends IsoObject
	{
		
		private var _animations:Dictionary;
		
		private var _animationOffsetContainer:Sprite = new Sprite();
		
		public var _currentAnimation:Animation;
		
		private var _spriteData:Object;
		
		private var _facing:String;
		
		private var _boardPosition:String;
		
		public function AnimatedSprite(animations:Dictionary, xoffset:Number, yoffset:Number, size:Number, facing:String, boardPosition:String, currentAnimationName:String) 
		{
			super(size);
			
			_animationOffsetContainer.x = -xoffset;
			_animationOffsetContainer.y = -yoffset;
			_facing = facing;
			_boardPosition = boardPosition;
			_animations = animations;
			
			this.name = name;
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		public function init(currentAnimationName:String):void {
			_currentAnimation = _animations[currentAnimationName];
			_animationOffsetContainer.addChild(_currentAnimation);
			addChild(_animationOffsetContainer);
		}
		
		public function moveTo(target:Square):void
		{
			var p3d:Point3D = target.position;
			var p:Point = IsoUtils.isoToScreen(p3d);
			TweenLite.to(this, 7, {x:p.x, y:p.y, onComplete : finishedWalking});
			_currentAnimation.start();
		}
		
		private function finishedWalking(e:Event):void
		{
			pause();	
		}
		
		public function attack(direction:String):void
		{
			_animationOffsetContainer.removeChild(_currentAnimation);
			_currentAnimation = _animations["attack " + direction];
			_animationOffsetContainer.addChild(_currentAnimation);
			_currentAnimation.start();
		}
		
		public function stop():void
		{
			_currentAnimation.stop();
		}
		
		public function start():void
		{
			_currentAnimation.start();
		}
		
		public function pause():void
		{
			_currentAnimation.pause();
		}
		
		public function show():void
		{
			_animationOffsetContainer.addChild(_currentAnimation);
		}
		
		public function hide():void
		{
			_animationOffsetContainer.removeChild(_currentAnimation);
		}
		
		public function set boardPosition(newPosition:String):void {
			_boardPosition = newPosition;
		}
		public function get boardPosition():String {
			return _boardPosition;
		}
	}
}