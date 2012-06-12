package de.bht.consilio.anim.command
{
	import flash.utils.Dictionary;

	public interface IMovementType
	{	
		function getAccessableSquares(position:String):Array;
		
		function getType():String;
	}
}