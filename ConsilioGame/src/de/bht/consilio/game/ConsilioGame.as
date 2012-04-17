package de.bht.consilio.game 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import de.bht.consilio.model.Board;
	import de.bht.consilio.model.Dwarf;
	import de.bht.consilio.model.Vladsword;
	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.anim.ConsilioEvent;
	import de.bht.consilio.model.board.ChessBoard;
	import de.bht.consilio.model.iso.IsoUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import mx.core.ButtonAsset;
	
	import org.osflash.thunderbolt.Logger;
	
	[SWF(width="1024",height="768",frameRate="30", backgroundColor="0x000000")]
	public class ConsilioGame extends Sprite{
		
		private var mySprite:AnimatedSprite;
		private var mySprite2:AnimatedSprite;
		
		private var myBoard:Board;
		
		private var chessboard:ChessBoard;
		
		public function ConsilioGame(){
			init();
		}
		
		private function init():void
		{
			chessboard = new ChessBoard( 0x333333, 0x999999 );
			addChild(chessboard);
			
			chessboard.x = 512;
			chessboard.y = 128;
			
			
			myBoard = new Board();
			
			myBoard.initialize();
			myBoard.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, addSprites);
		}
		
		private function addSprites(e:Event):void
		{
			myBoard.removeEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, addSprites);
			
//			addChild(myBoard);
			
			mySprite = new Dwarf("ne");
//			mySprite.x += 524;
//			mySprite.y += 539;
			mySprite.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void{
				Logger.log(Logger.INFO, "In Start Animation");
				var sprite:AnimatedSprite = e.target as AnimatedSprite;
				sprite.show();
				sprite.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					sprite.moveTo("ne");
					TweenLite.to(sprite, 8, {x:sprite.x + 65, y:sprite.y - 52, onComplete:sprite.pause});
				});
			});
			
//			myBoard.addSprite(mySprite);
//			addChild(mySprite);
			mySprite.position = chessboard.getSquare("a1").position;
			Logger.log(Logger.INFO, "Point: [" + mySprite.x + "; " + mySprite.y + "]");
//			mySprite.x = p.x;
//			mySprite.y = p.y;
			chessboard.addChild(mySprite);
			
			mySprite2 = new Vladsword("sw");
			mySprite2.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void{
				Logger.log(Logger.INFO, "In Start Animation");
				var sprite:AnimatedSprite = e.target as AnimatedSprite;
				sprite.show();
				sprite.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					sprite.moveTo("sw");
					TweenLite.to(sprite, 8, {x:sprite.x - 65, y:sprite.y + 52, onComplete:sprite.pause});
				});
			});
			
//			myBoard.addSprite(mySprite2);
//			addChild(mySprite2);
		}
	}
}