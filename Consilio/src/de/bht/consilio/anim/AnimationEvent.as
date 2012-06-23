package de.bht.consilio.anim
{
	import flash.events.Event;
	
	public class AnimationEvent extends Event
	{
		
		public static const ANIMATION_FINISHED:String = "animation finished";
		
		public function AnimationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}