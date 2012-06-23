package de.bht.consilio.anim.command
{
	import de.bht.consilio.command.IActionController;
	import de.bht.consilio.command.ICommand;
	import de.bht.consilio.controller.GameController;
	
	public class ActionController implements IActionController
	{
		private var _move:IMoveCommand;
		private var _attack:IAttackCommand;
		private var _special_1:ISpecialCommand;
		private var _special_2:ISpecialCommand;
		private var _special_3:ISpecialCommand;
		private var _special_4:ISpecialCommand;
		
		private var _current:ICommand;
		
		public function ActionController(move:IMoveCommand, attack:IAttackCommand, 
										 special_1:ISpecialCommand = null,
										 special_2:ISpecialCommand = null,
										 special_3:ISpecialCommand = null,
										 special_4:ISpecialCommand = null)
		{
			_move = move;
			_attack = attack;
			_special_1 = special_1 == null ? new NullSpecialCommand() : special_1;
			_special_2 = special_2 == null ? new NullSpecialCommand() : special_2;
			_special_3 = special_3 == null ? new NullSpecialCommand() : special_3;
			_special_4 = special_4 == null ? new NullSpecialCommand() : special_4;
		}
		
		public function move():void
		{
			_current = _move;
			_move.execute();
		}
		
		public function attack():void
		{
			_current = _attack;
			_attack.execute();
		}
		
		public function special_1():void
		{
			_current = _special_1;
			_special_1.execute();
		}
		
		public function special_2():void
		{
			_current = _special_2;
			_special_2.execute();
		}
		
		public function special_3():void
		{
			_current = _special_3;
			_special_3.execute();
		}
		
		public function special_4():void
		{
			_current = _special_3;
			_special_4.execute();
		}
		
		public function cancelLastCommand():void {
			if(_current){
				_current.cancel();
			}
		}
		
		public function canMove():Boolean 
		{
			return _move.hasTarget();
		}
		
		public function canAttack():Boolean
		{
			return _attack.hasTarget();
		}
		
		public function hasSpecialAction_1():Boolean
		{
			return _special_1.hasTarget();
		}
		
		public function hasSpecialAction_2():Boolean
		{
			return _special_2.hasTarget();
		}
		
		public function hasSpecialAction_3():Boolean
		{
			return _special_3.hasTarget();
		}
		
		public function hasSpecialAction_4():Boolean
		{
			return _special_4.hasTarget();
		}
		
		public function setSpecial_1(special_1:ISpecialCommand):void
		{
			_special_1 = special_1;
		}
		
		public function setSpecial_2(special_2:ISpecialCommand):void
		{
			_special_2 = special_2;
		}
		
		public function setSpecial_3(special_3:ISpecialCommand):void
		{
			_special_3 = special_3;
		}
		
		public function setSpecial_4(special_4:ISpecialCommand):void
		{
			_special_4 = special_4;
		}
	}
}