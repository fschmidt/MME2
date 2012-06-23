package de.bht.consilio.anim
{
	public class Attributes
	{
		
		private var _hpMax:uint;
		private var _hpCurrent:uint;
		
		private var _attackValue:uint;
		private var _defenseValue:uint;
		
		private var _movementValue:uint;
		private var _movementType:String;
		
		public function Attributes(hp:uint, attack:uint, defense:uint, movement:uint, movementType:String)
		{
			_hpMax = hp;
			_hpCurrent = hp;
			_attackValue = attack;
			_defenseValue = defense;
			_movementValue = movement;
			_movementType = movementType;
		}
		
		public function get maxHP():uint {
			return _hpMax;
		}
		
		public function get currentHP():uint {
			return _hpCurrent;
		}
		
		public function set currentHP(value:uint):void {
			_hpCurrent = value;
		}
		
		public function get attack():uint {
			return _attackValue;
		}
		
		public function get defense():uint {
			return _defenseValue;
		}
		
		public function get movement():uint {
			return _movementValue;
		}
		
		public function get movementType():String {
			return _movementType;
		}
	}
}