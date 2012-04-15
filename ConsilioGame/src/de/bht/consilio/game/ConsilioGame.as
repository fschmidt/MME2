package de.bht.consilio.game 
{
	import de.bht.consilio.model.Board;
	import de.bht.consilio.model.Dwarf;
	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.anim.ConsilioEvent;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	[SWF(width="640",height="500",frameRate="30")]
	public class ConsilioGame extends Sprite{
		
		private var mySprite:AnimatedSprite;
		private var mySprite2:AnimatedSprite;
		
		private var myBoard:Board;
		
		public function ConsilioGame(){
			init();
		}
		
		private function init():void{
			myBoard = new Board();
			
			myBoard.initialize();
			myBoard.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, addSprites);
		}
		
		private function addSprites(e:Event):void
		{
			myBoard.removeEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, addSprite);
			
			addChild(myBoard);
			
			mySprite = new Dwarf();
			mySprite.initialize();
			mySprite.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, startAnimation);
			
			mySprite2 = new Dwarf();
			mySprite2.initialize();
			mySprite2.x = 50;
			mySprite2.y = 50;
			mySprite2.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, startAnimation);
		}
		
		private function addSprite():void
		{
			
			
		}
		
		private function startAnimation(e:Event):void
		{
			var sprite:AnimatedSprite = e.target as AnimatedSprite;
			sprite.removeEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, startAnimation);
			
			sprite.startAnimation(myBoard);
		}
	}
}