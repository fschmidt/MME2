package de.bht.consilio.game  
{
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.board.Board;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import spark.core.SpriteVisualElement;
	
	public class ConsilioGame extends SpriteVisualElement{
		
		private static var SPRITE_SHEETS_LOCATION:String = "img/sprite_sheets/";
		
		private var chessboard:Board;
		private var boardData:Object;
		
		public function ConsilioGame(){
			init();
		}
		
		private function init():void
		{
			LoaderMax.activate([ImageLoader]);
			
			
			chessboard = new Board( 0x333333, 0x999999 );
			addChild(chessboard);
			
			chessboard.x = 512;
			chessboard.y = 60;
			
			var myRequest:URLRequest = new URLRequest("img/boards/boardData.json");
			var myLoader:URLLoader = new URLLoader(); 
			myLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				boardData = JSON.parse(e.target.data);
				
				var pieces:Array = boardData.pieces as Array;
				var files:Dictionary = new Dictionary();
				var urls:Array = new Array();
				
				for (var i:int = 0; i < pieces.length; i++) {
					var filename:String = pieces[i].name + ".png";
					if(!(filename in files))
					{
						files[filename] = 1;
						urls.push(filename);
					}
				}
		

				LoaderMax.activate([ImageLoader]);
				var queue:LoaderMax = LoaderMax.parse(urls, {maxConnections:1, onProgress:_progressHandler, onComplete:_queueCompleteHandler, onChildComplete:_childCompleteHandler});
				queue.prependURLs(SPRITE_SHEETS_LOCATION);
				queue.load();

			});
			myLoader.load(myRequest);
		}
		
		private function _progressHandler(event:LoaderEvent):void
		{
			trace(event.target.progress);
		}
		
		private function _queueCompleteHandler(event:LoaderEvent):void
		{
			chessboard.init(boardData);
		}
		
		private function _childCompleteHandler(event:LoaderEvent):void
		{
			var i:ImageLoader = event.target as ImageLoader;
			var name:String = i.url.substr(SPRITE_SHEETS_LOCATION.length);
			trace(name);
			AnimatedSprite.addSpriteSheet(name, (i.rawContent as Bitmap).bitmapData);
		}
	}
}