package de.bht.consilio.command
{
	public interface IActionController
	{
		function move():void;
		function attack():void;
		function special_1():void;
		function special_2():void;
		function special_3():void;
		function special_4():void;
		
		function cancelLastCommand():void;
		
		function canMove():Boolean;
		function canAttack():Boolean;
		
		function hasSpecialAction_1():Boolean;
		function hasSpecialAction_2():Boolean;
		function hasSpecialAction_3():Boolean;
		function hasSpecialAction_4():Boolean;
	}
}