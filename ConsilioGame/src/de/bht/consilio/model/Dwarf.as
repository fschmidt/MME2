package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	import flash.events.MouseEvent;
	
	public class Dwarf extends AnimatedSprite
	{
		public function Dwarf(facing:String)
		{
//			this.x = -48;
//			this.y = -60;
			super("img/dwarf96/", "dwarf.json", facing);
		}
	}
}