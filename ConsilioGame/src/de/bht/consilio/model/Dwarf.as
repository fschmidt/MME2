package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	import org.osflash.thunderbolt.Logger;
	
	public class Dwarf extends AnimatedSprite
	{
		public function Dwarf()
		{
			super();
			
			locations = new Array();
			
			locations[0] = new Array();
			
			for (var i:int = 0; i < 8; i++) {
				locations[0].push("img/dwarf96/" + "walking ne000" + i + ".png");
			}
		}
	}
}