package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	public class FullPlatedKnight extends AnimatedSprite
	{
		public function FullPlatedKnight(facing:String)
		{
			super(96, 55, 65,"img/pieces/fullplated_knight/", "fullplatedknight.json", facing);
		}
	}
}