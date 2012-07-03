package de.bht.consilio.game  
{

	
	import de.bht.consilio.anim.AnimatedSprite;
	import de.bht.consilio.application.ConsilioApplication;
	import de.bht.consilio.board.Board;
	import de.bht.consilio.controller.GameController;
	import de.bht.consilio.custom_components.view.BottomMenu;
	import de.bht.consilio.util.Constants;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
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
		
		[Embed(source="img/battle.jpg")]
		private var background:Class;
		[Embed(source="img/boards/boardData.txt", mimeType="application/octet-stream")]
		private var boardData:Class;
		
		private var chessboard:Board;
		
		public function ConsilioGame(isWhitePlayer:Boolean){
			init(isWhitePlayer);
		}
		
		/**
		 * Initializes the game by loading the boardData and initializing the board
		 * 
		 */
		private function init(isWhitePlayer:Boolean):void
		{
			// create the board
			chessboard = new Board( Constants.SQUARE_COLOR_WHITE, Constants.SQUARE_COLOR_BLACK );
			var bg:Bitmap = new background();
			addChild(bg);
			addChild(chessboard);
			
			var ba : ByteArray = new boardData() as ByteArray;
			var boardData:Object = JSON.parse(ba.readUTFBytes(ba.length));
			
			chessboard.init(boardData, isWhitePlayer);
			
			var g:GameController = GameController.newGameController(chessboard, ConsilioApplication.getInstance().actionMenu, isWhitePlayer);
			
		}
	}
}