package  
{
	
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.board.Board;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	
	[SWF(width="1024",height="768",frameRate="30", backgroundColor="0x000000")]
	public class ConsilioGame extends Sprite{
		
		private var chessboard:Board;
		private var boardData:Object;
		
		public function ConsilioGame(){
//			
//			var b:Bitmap = AnimatedSprite.test();
//			b.cacheAsBitmap = false;
//			b.bitmapData.lock();
//			trace("Memory used: " + Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "Mb");
//			var i:uint = b.bitmapData.getPixel(0,0);
//			trace("Memory used: " + Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "Mb");
//			
//			var b2:Bitmap = AnimatedSprite.test(1);
//			b2.cacheAsBitmap = false;
//			b2.bitmapData.lock();
//			var i2:uint = b2.bitmapData.getPixel(0,0);
			
			init();
		}
		
		private function init():void
		{
			
			
			chessboard = new Board( 0x333333, 0x999999 );
			addChild(chessboard);
			
			chessboard.x = 512;
			chessboard.y = 128;
			
			var myRequest:URLRequest = new URLRequest("img/boards/boardData.json");
			var myLoader:URLLoader = new URLLoader(); 
			myLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				boardData = JSON.parse(e.target.data);
				chessboard.init(boardData);
			});
			myLoader.load(myRequest);
		}
		
	}
}