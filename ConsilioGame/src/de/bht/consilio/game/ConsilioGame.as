package de.bht.consilio.game 
{
	
	import de.bht.consilio.model.board.Board;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	[SWF(width="1024",height="768",frameRate="30", backgroundColor="0x000000")]
	public class ConsilioGame extends Sprite{
		
		private var chessboard:Board;
		private var boardData:Object;
		
		public function ConsilioGame(){
			
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