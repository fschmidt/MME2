package de.bht.consilio.model.iso
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class IsoObject extends Sprite
	{
		protected var _position:Point3D;
		protected var _size:Number;
		protected var _walkable:Boolean = false;
		
		public function IsoObject(size:Number)
		{
			_size = size;
			_position = new Point3D();
			updateScreenPosition();
		}
		
		protected function updateScreenPosition():void
		{
			var screenPosition:Point = IsoUtils.isoToScreen(_position);
			super.x = screenPosition.x;
			super.y = screenPosition.y;
		}
		
		override public function get x():Number
		{
			return _position.x;
		}
		
		override public function set x(value:Number):void
		{
			_position.x = value;
			updateScreenPosition();
		}
		
		override public function get y():Number
		{
			return _position.y;
		}
		
		override public function set y(value:Number):void
		{
			_position.y = value;
			updateScreenPosition();
		}
		
		override public function get z():Number
		{
			return this.position.z;
		}
		
		override public function set z(value:Number):void
		{
			this.position.z = value;
			updateScreenPosition();
		}
		
		public function set position(value:Point3D):void
		{
			_position = value;
			updateScreenPosition();
		}
		
		public function get position():Point3D
		{
			return _position;
		}
		
		public function get centerWC():Point
		{
			var p:Point = IsoUtils.isoToScreen(_position);
			p.x+=size/2;
			p.y+=size/2;
			return p;
		}
		
		public function get size():Number
		{
			return _size;
		}
	}
}