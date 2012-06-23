package de.bht.consilio.anim
{
	import de.bht.consilio.anim.command.ActionController;
	import de.bht.consilio.anim.command.BasicHorizontalAttackCommand;
	import de.bht.consilio.anim.command.BasicHorizontalMoveCommand;
	import de.bht.consilio.anim.command.IMoveCommand;
	import de.bht.consilio.anim.command.NullAttackCommand;
	import de.bht.consilio.command.IActionController;
	
	import flash.events.Event;
	

	public class Piece extends AnimatedSprite
	{
		private var _isOwnPiece:Boolean;
		private var _attributes:Attributes;		
		private var _controller:ActionController;
		
		public function Piece(name:String, boardPosition:String, facing:String, isOwnPiece:Boolean, attributes:Attributes)
		{
			super(name, boardPosition, facing);
			_isOwnPiece = isOwnPiece;
			_controller = new ActionController(new BasicHorizontalMoveCommand(this), new BasicHorizontalAttackCommand(this));
			_attributes = attributes;
		}
		
		public function get isOwnPiece():Boolean {
			return _isOwnPiece;
		}
		
		public function get control():IActionController 
		{
			return _controller;
		}
		
		public function get attributes():Attributes {
			return _attributes;
		}
		
		public function attack(target:Piece):void {
			this.setCurrentAnimation("attack");
			this.addEventListener(AnimationEvent.ANIMATION_FINISHED, function(e:Event):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				e.currentTarget.stopCurrentAnimation();
				e.currentTarget.setCurrentAnimation("walking");
			});
			target.setCurrentAnimation("been hit");
			target.addEventListener(AnimationEvent.ANIMATION_FINISHED, function(e:Event):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				e.currentTarget.stopCurrentAnimation();
				e.currentTarget.setCurrentAnimation("walking");
			});
			this.startCurrentAnimation();
			target.startCurrentAnimation();
			target.attributes.currentHP -= (this.attributes.attack - target.attributes.defense);
		}
	}
}