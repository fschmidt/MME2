package de.bht.consilio.anim
{
	import de.bht.consilio.anim.command.ActionController;
	import de.bht.consilio.anim.command.AdvancedHorizontalMoveCommand;
	import de.bht.consilio.anim.command.BasicHorizontalAttackCommand;
	import de.bht.consilio.anim.command.IAttackCommand;
	import de.bht.consilio.anim.command.IMoveCommand;
	import de.bht.consilio.util.Constants;

	public class Attributes
	{
		
		private var _hpMax:uint;
		private var _hpCurrent:int;
		
		private var _attackValue:uint;
		private var _attackRange:uint;
		private var _attackType:String;
		
		private var _defenseValue:uint;
		
		private var _movementValue:uint;
		private var _movementType:String;
		
		private var _selectionAnimation:String;
		private var _randomAnimation:String;
		
		
		public function Attributes(hp:uint, attack:uint, range:uint, defense:uint, movement:uint, 
								   movementType:String, attackType:String, randomAnimationName:String, 
								   selectionAnimationName:String = Constants.ANIMATION_WALKING)
		{
			_hpMax = hp;
			_hpCurrent = hp;
			_attackValue = attack;
			_attackRange = range;
			_defenseValue = defense;
			_movementValue = movement;
			_movementType = movementType;
			_attackType = attackType;
			_selectionAnimation = selectionAnimationName;
			_randomAnimation = randomAnimationName;
		}
		
		public static function newAttributesForPiece(name:String):Attributes {
			switch(name)
			{
				case "greendwarf": {
					return new Attributes(40, 25, 1, 5, 1, Constants.MOVEMENT_TYPE_HORIZONTAL, Constants.ATTACK_TYPE_BASIC, Constants.ANIMATION_LOOKING);
				}
				case "red_knight": {
					return new Attributes(40, 30, 1, 0, 1, Constants.MOVEMENT_TYPE_HORIZONTAL, Constants.ATTACK_TYPE_BASIC, Constants.ANIMATION_TALKING);
				}
				case "hunter": {
					return new Attributes(35, 50, 2, 0, 2, Constants.MOVEMENT_TYPE_HORIZONTAL_ADVANCED, Constants.ATTACK_TYPE_SHOOTING, Constants.ANIMATION_LOOKING);
				}
				case "red_archer": {
					return new Attributes(35, 50, 2, 0, 2, Constants.MOVEMENT_TYPE_HORIZONTAL_ADVANCED, Constants.ATTACK_TYPE_SHOOTING, Constants.ANIMATION_TALKING);
				}
				case "fullplated_knight": {
					return new Attributes(65, 45, 2, 15, 4, Constants.MOVEMENT_TYPE_HORIZONTAL_ADVANCED, Constants.ATTACK_TYPE_ADVANCED, Constants.ANIMATION_GREETING);
				}
				case "axestan_shield": {
					return new Attributes(65, 50, 2, 10, 4, Constants.MOVEMENT_TYPE_HORIZONTAL_ADVANCED, Constants.ATTACK_TYPE_ADVANCED, Constants.ANIMATION_TALKING);
				}
				case "white_mage": {
					return new Attributes(30, 30, 4, 5, 4, Constants.MOVEMENT_TYPE_VERTICAL, Constants.ATTACK_TYPE_MAGIC_SPELLING, Constants.ANIMATION_TALKING);
				}
				case "black_mage": {
					return new Attributes(30, 30, 4, 5, 4, Constants.MOVEMENT_TYPE_VERTICAL, Constants.ATTACK_TYPE_MAGIC_SPELLING, Constants.ANIMATION_TALKING);
				}
					
				case "queen": {
					return new Attributes(70, 50, 3, 10, 8, Constants.MOVEMENT_TYPE_BOTH, Constants.ATTACK_TYPE_ADVANCED, Constants.ANIMATION_GREETING);
				}
					
				case "dark_princess": {
					return new Attributes(70, 55, 3, 5, 8, Constants.MOVEMENT_TYPE_BOTH, Constants.ATTACK_TYPE_ADVANCED, Constants.ANIMATION_KNIT);
				}
					
				case "bjorn": {
					return new Attributes(100, 40, 1, 15, 1, Constants.MOVEMENT_TYPE_BOTH, Constants.ATTACK_TYPE_ADVANCED, Constants.ANIMATION_LOOKING);
				}
					
				case "black_knight": {
					return new Attributes(100, 40, 1, 15, 1, Constants.MOVEMENT_TYPE_BOTH, Constants.ATTACK_TYPE_ADVANCED, Constants.ANIMATION_TALKING);
				}
					
				default:
				{
					return new Attributes(1, 1, 1, 1, 1, Constants.MOVEMENT_TYPE_HORIZONTAL, Constants.ATTACK_TYPE_BASIC, Constants.ANIMATION_WALKING);
				}
			}
		}
		
		public function get maxHP():uint {
			return _hpMax;
		}
		
		public function get currentHP():int {
			return _hpCurrent;
		}
		
		public function set currentHP(value:int):void {
			_hpCurrent = value;
		}
		
		public function get attack():uint {
			return _attackValue;
		}
		
		public function get attackRange():uint {
			return _attackRange;
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
		
		public function get attackType():String {
			return _attackType;
		}
		
		public function get selectionAnimation():String {
			return _selectionAnimation;
		}
		
		public function get randomAnimation():String {
			return _randomAnimation;
		}
		
	}
}