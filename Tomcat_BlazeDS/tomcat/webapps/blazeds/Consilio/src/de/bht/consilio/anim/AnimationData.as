package de.bht.consilio.anim
{
	/**
	 * Class containing nessessary data for animations
	 * 
	 * @author Frank Schmidt
	 * 
	 */
	public class AnimationData
	{
		/**
		 * 
		 */
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