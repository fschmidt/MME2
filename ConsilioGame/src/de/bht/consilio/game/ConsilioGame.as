package de.bht.consilio.game 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import de.bht.consilio.model.Board;
	import de.bht.consilio.model.Dwarf;
	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.anim.ConsilioEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.thunderbolt.Logger;
	
	[SWF(width="1024",height="768",frameRate="30", backgroundColor="0x000000")]
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
			myBoard.removeEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, addSprites);
			
			addChild(myBoard);
			
			mySprite = new Dwarf();
			mySprite.x = 329;
			mySprite.y = 498;
			mySprite.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, startAnimation);
			myBoard.addSprite(mySprite);
			
			//			mySprite2 = new Dwarf();
			//			mySprite2.initialize();
			//			mySprite2.x = 220;
			//			mySprite2.y = 430;
			//			mySprite2.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, startAnimation);
		}
		
		private function startAnimation(e:Event):void
		{
			Logger.log(Logger.INFO, "In Start Animation");
			var sprite:AnimatedSprite = e.target as AnimatedSprite;
			sprite.removeEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, startAnimation);
			sprite.show();
			sprite.moveTo("null");
			sprite.addEventListener(MouseEvent.CLICK, function(e:Event):void 
			{
				var target:Sprite = e.target as Sprite;
				TweenLite.to(target, 10, {x:target.x + 65, y:target.y - 52});
			});
		}
	}
}