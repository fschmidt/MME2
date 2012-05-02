package de.bht.consilio.util
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	import flash.events.Event;
	
	public class AnimatedSpriteFactoryEvent extends Event
	{
		public static const ON_SPRITE_CLOAD_COMPLETE:String = "Sprite loading complete";
		private var _result:AnimatedSprite;
		
		public function AnimatedSpriteFactoryEvent(type:String, result:AnimatedSprite = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_result = result;
			super(type, bubbles, cancelable);
		}
		
		public function get result():AnimatedSprite
		{
			return _result;
		}
	}
}