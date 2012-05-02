package de.bht.consilio.model.anim
{
	public class AnimationData
	{
		private var _frames:Array;
		
		public function AnimationData()
		{
			_frames = new Array();
		}
		
		public function get frames():Array
		{
			return _frames;
		}
	}
}