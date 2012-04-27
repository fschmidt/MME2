package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	public class Vladsword extends AnimatedSprite
	{
		public function Vladsword(facing:String)
		{
			super(96, 55, 65,"img/pieces/vladsword96/", "vladsword.json", facing);
		}
	}
}