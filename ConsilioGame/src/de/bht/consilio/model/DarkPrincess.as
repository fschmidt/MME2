package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	public class DarkPrincess extends AnimatedSprite
	{
		public function DarkPrincess(facing:String)
		{
			super(96, 55, 65,"img/dark_princess/", "darkprincess.json", facing);
		}
	}
}