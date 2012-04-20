package de.bht.consilio.model
{
	import de.bht.consilio.model.anim.AnimatedSprite;
	
	public class TFreyaAxe extends AnimatedSprite
	{
		public function TFreyaAxe(facing:String)
		{
			super(96, 70, 80,"img/T_freya_axe/", "tfreyaaxe.json", facing);
		}
	}
}