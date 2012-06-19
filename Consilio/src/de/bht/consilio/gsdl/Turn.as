package de.bht.consilio.gsdl
{
	public class Turn
	{
		private var action:String;
		private var source:String;
		private var target:String;
		
		public function Turn(action:String, source:String, target:String)
		{
			this.action = action;
			this.source = source;
			this.target = target;
		}
		
		public function get action():String {
			return this.action;
		}
		
		public function get source():String {
			return this.source;
		}
		
		public function get target():String {
			return this.target;
		}
	}
}