package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	public class WhiteMage extends AnimatedSprite
	{
		public function WhiteMage(facing:String)
		{
			super(96, 55, 65,"img/white_mage/", "whitemage.json", facing);
		}
	}
}