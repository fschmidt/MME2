package de.bht.consilio.game 
{

	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.anim.ConsilioEvent;
	import de.bht.consilio.model.board.Board;
	import de.bht.consilio.model.board.Square;
	import de.bht.consilio.model.menu.CircleMenu;
	import de.bht.consilio.util.AnimatedSpriteFactory;
	import de.bht.consilio.util.AnimatedSpriteFactoryEvent;
	import de.bht.consilio.util.ResourceLoader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.thunderbolt.Logger;
	
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
				boardData = JSON.parse(e.target.data);
				addSprites(boardData.pieces as Array);
			});
			myLoader.load(myRequest);
			
			
			
		}
		
		private function addSprites(pieces:Array):void {
			
			for (var i:int = 0; i < pieces.length; i++) {
				
				var myRequest:URLRequest = new URLRequest("piece_descriptions/" + pieces[i].name + ".json");
				
				var myLoader:ResourceLoader = new ResourceLoader(pieces[i].name, pieces[i]);
				
				myLoader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, function(e:ConsilioEvent):void {
					
					var data:Object = ((e.target) as ResourceLoader).getData();
					
					var factory:AnimatedSpriteFactory = new AnimatedSpriteFactory();
					
					factory.addEventListener(AnimatedSpriteFactoryEvent.ON_SPRITE_CLOAD_COMPLETE, addSprite);
					
					factory.createAnimatedSpriteFromJsonDescription("img/pieces/", e.data, data.facing, data.position);
					
				});
				myLoader.loadURL(myRequest);
			}
		}
		
		private function addSprite(e:AnimatedSpriteFactoryEvent):void {
			var s:AnimatedSprite = e.result;
			s.position = chessboard.getSquare(s.boardPosition).position;
			chessboard.getSquare(s.boardPosition).registerSprite(s);
			chessboard.addChild(s);
		}
	}
}