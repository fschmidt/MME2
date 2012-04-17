package de.bht.consilio.model.iso
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	
	/**
	 * From: AdvancED ActionScript 3.0 Animation By Keith Peters
	 * @author Keith Peters
	 */
	public class IsoUtils extends Sprite
	{
		
		public static const Y_CORRECT:Number=Math.cos(-Math.PI/6)*Math.SQRT2;
		
		public function IsoUtils()
		{
			
		}
		public static function isoToScreen(pos:Point3D):Point
		{
			var screenX:Number = pos.x -pos.z;
			var screenY:Number = pos.y * Y_CORRECT + (pos.x+pos.z)*.5;
			return new Point(screenX, screenY);
		}
		
		public static function screenToIso(point:Point):Point3D
		{
			var xPos:Number = point.y -point.x*.5;
			var yPos:Number = 0;
			var zPos:Number = point.y -point.x*.5;
			return new Point3D(xPos, yPos, zPos);
		}
		
		
	}
}