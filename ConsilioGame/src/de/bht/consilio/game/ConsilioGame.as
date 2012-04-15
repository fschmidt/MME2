package de.bht.consilio.game 
{
	import de.bht.consilio.model.Board;
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
		
		private var myBoard:Board;
		
		public function ConsilioGame(){
			trace("here");
			init();
		}
		
		private function init():void{
			myBoard = new Board();
			
			myBoard.initialize();
			myBoard.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, addSprite);
		}
		
		private function addSprite(e:Event):void
		{
			myBoard.removeEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, addSprite);
			mySprite = new AnimatedSprite();
			mySprite.initialize();
			mySprite.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, startAnimation);
		}
		
		private function startAnimation(e:Event):void
		{
			mySprite.removeEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, startAnimation);
			addChild(myBoard);
			mySprite.startAnimation(myBoard);
		}
		

	}
}