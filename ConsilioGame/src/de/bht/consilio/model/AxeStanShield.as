package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	public class AxeStanShield extends AnimatedSprite
	{
		public function AxeStanShield(facing:String)
		{
			super(96, 55, 65,"img/axestan_shield/", "axestanshield.json", facing);
		}
	}
}