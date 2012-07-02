package de.bht.consilio.anim
{
	import de.bht.consilio.anim.command.ActionController;
	import de.bht.consilio.anim.command.AdvancedHorizontalMoveCommand;
	import de.bht.consilio.anim.command.AdvancedVerticalMoveCommand;
	import de.bht.consilio.anim.command.BasicHorizontalAttackCommand;
	import de.bht.consilio.anim.command.BasicMoveCommand;
	import de.bht.consilio.anim.command.IAttackCommand;
	import de.bht.consilio.anim.command.IMoveCommand;
	import de.bht.consilio.anim.command.NullAttackCommand;
	import de.bht.consilio.anim.command.ShootingAttackCommand;
	import de.bht.consilio.board.Square;
	import de.bht.consilio.command.IActionController;
	import de.bht.consilio.controller.GameController;
	import de.bht.consilio.event.ActionEvent;
	import de.bht.consilio.event.ConsilioEvent;
	import de.bht.consilio.iso.IsoUtils;
	import de.bht.consilio.util.ActionCommandFactory;
	import de.bht.consilio.util.Constants;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	
	public class Piece extends AnimatedSprite
	{
		private var _isOwnPiece:Boolean;
		private var _attributes:Attributes;		
		private var _controller:ActionController;
		private var _attackAnimationName:String;
		
		public function Piece(name:String, boardPosition:String, facing:String, isOwnPiece:Boolean, attributes:Attributes)
		{
			super(name, boardPosition, facing);
			_isOwnPiece = isOwnPiece;
			if(attributes.attackType == Constants.ATTACK_TYPE_BASIC || attributes.attackType == Constants.ATTACK_TYPE_ADVANCED) {
				_attackAnimationName = "attack";
			} else {
				_attackAnimationName = attributes.attackType;
			}
			_controller = new ActionController(ActionCommandFactory.moveCommandForAttributes(attributes, this), ActionCommandFactory.attackCommandForAttributes(attributes, this));
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
			this.setCurrentAnimation(_attackAnimationName);
			this.addEventListener(AnimationEvent.ANIMATION_FINISHED, function(e:Event):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				e.currentTarget.stopCurrentAnimation();
				e.currentTarget.setCurrentAnimation(e.currentTarget.attributes.selectionAnimation);
			});
			target.setCurrentAnimation("been hit");
			target.addEventListener(AnimationEvent.ANIMATION_FINISHED, function(e:Event):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				e.currentTarget.stopCurrentAnimation();
				if(e.currentTarget.attributes.currentHP <= 0) {
					e.currentTarget.die();
				} else {
					e.currentTarget.setCurrentAnimation(e.currentTarget.attributes.selectionAnimation);
					e.currentTarget.dispatchEvent(new ActionEvent(ActionEvent.COMPLETE));
					e.currentTarget.dispatchEvent(new Event(Event.COMPLETE));
				}
			});
			this.startCurrentAnimation();
			target.startCurrentAnimation();
			target.attributes.currentHP -= (this.attributes.attack - target.attributes.defense);
		}
		
		override public function moveTo(target:Square):void {
			var source:Square = GameController.getInstance().getSquareById(boardPosition);
			super.moveTo(target);
			
			target.registeredPiece = this;
			target.makeSelectable(true);
			target.isOccupied = true;
			source.registeredPiece = null;
			source.isOccupied = false;
			target.redraw(target.color);
			source.redraw(source.color);
			source.makeSelectable(false);
			dispatchEvent(new ActionEvent(ActionEvent.COMPLETE));
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function die():void {
			this.stopCurrentAnimation();
			this.setCurrentAnimation("tipping over");
			this.addEventListener(AnimationEvent.ANIMATION_FINISHED, function(e:Event):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				e.currentTarget.stopCurrentAnimation();
				e.currentTarget.canStartIdleAnimation(false);
				GameController.getInstance().removeFromGame(e.currentTarget as Piece);
				dispatchEvent(new ActionEvent(ActionEvent.COMPLETE));
				dispatchEvent(new Event(Event.COMPLETE));
			});
			this.startCurrentAnimation();
		}
		
		public function canStartIdleAnimation(b:Boolean):void {
			if(b==true) {
			this.addEventListener(Event.ENTER_FRAME, startIdleAnimation);
			} else {
				this.removeEventListener(Event.ENTER_FRAME, startIdleAnimation);
			}
		}
		
		private function startIdleAnimation(e:Event):void {
			if(Math.random() < 0.001) {
				setCurrentAnimation(_attributes.randomAnimation);
				startCurrentAnimation();
				addEventListener(AnimationEvent.ANIMATION_FINISHED, onRandomAnimationFinish);
			}
		}
		
		private function onRandomAnimationFinish(e:Event):void {
			e.currentTarget.removeEventListener( e.type, arguments.callee );
			stopCurrentAnimation();
			setCurrentAnimation(_attributes.selectionAnimation);
		}
	}
}