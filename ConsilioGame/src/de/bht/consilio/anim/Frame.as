package de.bht.consilio.anim
{
	public class Frame
	{
		
		private var _x:uint;
		private var _y:uint;
		private var _w:uint;
		private var _h:uint;
		
		
		public function Frame(x:uint, y:uint, w:uint, h:uint)
		{
			_x = x;
			_y = y;
			_w = w;
			_h = h;
		}
		
		public function get x():uint
		{
			return _x;
		}
		
		public function get y():uint
		{
			return _y;
		}
		
		public function get w():uint
		{
			return _w;
		}
		
		public function get h():uint
		{
			return _h;
		}
	}
}