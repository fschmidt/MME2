package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	public class BlackMage extends AnimatedSprite
	{
		public function BlackMage(facing:String)
		{
			super(96, 55, 65,"img/pieces/black_mage/", "blackmage.json", facing);
		}
	}
}