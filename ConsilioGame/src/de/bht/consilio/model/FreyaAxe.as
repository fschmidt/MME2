package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	public class FreyaAxe extends AnimatedSprite
	{
		public function FreyaAxe(facing:String)
		{
			super(96, 70, 80,"img/pieces/freya_axe/", "freyaaxe.json", facing);
		}
	}
}