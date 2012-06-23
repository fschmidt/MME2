package de.bht.consilio.gsdl
{
	public class Turn
	{
		public var action:String;
		public var source:String;
		public var target:String;
		
		public function Turn(action:String, source:String, target:String)
		{
			this.action = action;
			this.source = source;
			this.target = target;
		}
	}
}