package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	import flash.events.MouseEvent;
	
	public class Dwarf extends AnimatedSprite
	{
		public function Dwarf(facing:String)
		{
			super(96, 55, 60, "img/pieces/dwarf96/", "dwarf.json", facing);
		}
	}
}