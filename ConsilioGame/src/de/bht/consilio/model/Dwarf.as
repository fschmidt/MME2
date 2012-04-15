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
			
			for (var j:int = 9; j >= 0; j--) {
				locations.push("img/dwarf96/" + "attack ne000" + j + ".png");
			}
			
			for (var i:int = 7; i >= 0; i--) {
				locations.push("img/dwarf96/" + "walking ne000" + i + ".png");
			}
		}
	}
}