package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;

	public class Vladsword extends AnimatedSprite
	{
		public function Vladsword(facing:String)
		{
			this.x = -48;
			this.y = -60;
			super(96,96,48,"img/vladsword96/", "vladsword.json", facing);
		}
	}
}