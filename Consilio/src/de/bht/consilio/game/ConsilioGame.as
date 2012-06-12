package de.bht.consilio.game  
{
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import de.bht.ConsilioCustomComponents.BottomMenu;
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.board.Board;
	import de.bht.consilio.controller.GameController;
	import de.bht.consilio.util.Constants;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import spark.core.SpriteVisualElement;
	
	/**
	 * Main class for Consilio games
	 * 
	 * @author Frank Schmidt
	 * 
	 */
	public class ConsilioGame extends SpriteVisualElement{
		
		private static var SPRITE_SHEETS_LOCATION:String = "img/sprite_sheets/";
		
		private var chessboard:Board;
		private var boardData:Object;
		
		public function ConsilioGame(){
			init();
		}
		
		/**
		 * Initializes the game by loading the boardData and initializing the board
		 * 
		 */
		private function init():void
		{
			LoaderMax.activate([ImageLoader]);
			
			// create the board
			chessboard = new Board( Constants.SQUARE_COLOR_WHITE, Constants.SQUARE_COLOR_BLACK );
			addChild(chessboard);
			
			// load the board data
			var myRequest:URLRequest = new URLRequest("img/boards/boardData.json");
			var myLoader:URLLoader = new URLLoader(); 
			myLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				boardData = JSON.parse(e.target.data);
				
				chessboard.init(boardData);
				var g:GameController = new GameController(chessboard, true);
				
//				var pieces:Array = boardData.pieces as Array;
//				var files:Dictionary = new Dictionary();
//				var urls:Array = new Array();
//				
//				// load the pieces descriptions used
//				for (var i:int = 0; i < pieces.length; i++) {
//					var filename:String = pieces[i].name + ".png";
//					if(!(filename in files))
//					{
//						files[filename] = 1;
//						urls.push(filename);
//					}
//				}
//
//				LoaderMax.activate([ImageLoader]);
//				var queue:LoaderMax = LoaderMax.parse(urls, {maxConnections:1, onProgress:_progressHandler, onComplete:_queueCompleteHandler, onChildComplete:_childCompleteHandler});
//				queue.prependURLs(SPRITE_SHEETS_LOCATION);
//				queue.load();
//
			});
			myLoader.load(myRequest);
		}
	}
}