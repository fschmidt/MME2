package de.bht.consilio.game 
{
	import com.greensock.TweenLite;
	
	import de.bht.consilio.model.AxeStanShield;
	import de.bht.consilio.model.BlackMage;
	import de.bht.consilio.model.DarkPrincess;
	import de.bht.consilio.model.Dwarf;
	import de.bht.consilio.model.TFreyaAxe;
	import de.bht.consilio.model.Vladsword;
	import de.bht.consilio.model.WhiteMage;
	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.anim.ConsilioEvent;
	import de.bht.consilio.model.board.ChessBoard;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.formats.WhiteSpaceCollapse;
	
	[SWF(width="1024",height="768",frameRate="30", backgroundColor="0x000000")]
	public class ConsilioGame extends Sprite{
		
		private var mySprite:AnimatedSprite;
		private var mySprite2:AnimatedSprite;
		
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
			
			addSprites();
		}
		
		private function addSprites():void
		{
			for(var i:int = 1; i < 9; i++)
			{
				var dwarf:Dwarf = new Dwarf("ne");
				dwarf.position = chessboard.getSquare(String.fromCharCode(64+i).toLowerCase()+"2").position;
				chessboard.addChild(dwarf);
				dwarf.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
				{
					var s:AnimatedSprite = e.target as AnimatedSprite;
					s.show();
					s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
					{
						s.moveTo("ne");
//						TweenLite.to(s, 8, {x:s.x + 65, y:s.y - 52, onComplete:s.pause});
					});
				});
			}
			
			for(var j:int = 1; j < 9; j++)
			{
				var vlad:Vladsword = new Vladsword("sw");
				vlad.position = chessboard.getSquare(String.fromCharCode(64+j).toLowerCase()+"7").position;
				chessboard.addChild(vlad);
				vlad.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
				{
					var s:AnimatedSprite = e.target as AnimatedSprite;
					s.show();
					s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
					{
						s.moveTo("sw");
					});
				});
			}
			
			var dprin:DarkPrincess = new DarkPrincess("sw");
			dprin.position = chessboard.getSquare("e8").position;
			chessboard.addChild(dprin);
			dprin.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
			{
				var s:AnimatedSprite = e.target as AnimatedSprite;
				s.show();
				s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					s.moveTo("sw");
				});
			});
			
			var dprin2:DarkPrincess = new DarkPrincess("ne");
			dprin2.position = chessboard.getSquare("e1").position;
			chessboard.addChild(dprin2);
			dprin2.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
			{
				var s:AnimatedSprite = e.target as AnimatedSprite;
				s.show();
				s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					s.moveTo("ne");
				});
			});
			
			var wmage:WhiteMage = new WhiteMage("ne");
			wmage.position = chessboard.getSquare("c1").position;
			chessboard.addChild(wmage);
			wmage.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
			{
				var s:AnimatedSprite = e.target as AnimatedSprite;
				s.show();
				s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					s.moveTo("ne");
				});
			});
			
			var wmage2:WhiteMage = new WhiteMage("ne");
			wmage2.position = chessboard.getSquare("f1").position;
			chessboard.addChild(wmage2);
			wmage2.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
			{
				var s:AnimatedSprite = e.target as AnimatedSprite;
				s.show();
				s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					s.moveTo("ne");
				});
			});
			
			var bmage:BlackMage = new BlackMage("sw");
			bmage.position = chessboard.getSquare("c8").position;
			chessboard.addChild(bmage);
			bmage.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
			{
				var s:AnimatedSprite = e.target as AnimatedSprite;
				s.show();
				s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					s.moveTo("sw");
				});
			});
			
			var bmage2:BlackMage = new BlackMage("sw");
			bmage2.position = chessboard.getSquare("f8").position;
			chessboard.addChild(bmage2);
			bmage2.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
			{
				var s:AnimatedSprite = e.target as AnimatedSprite;
				s.show();
				s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					s.moveTo("sw");
				});
			});
			
			var freya:TFreyaAxe = new TFreyaAxe("ne");
			freya.position = chessboard.getSquare("a1").position;
			chessboard.addChild(freya);
			freya.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
			{
				var s:AnimatedSprite = e.target as AnimatedSprite;
				s.show();
				s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					s.moveTo("ne");
				});
			});
			
			var freya2:TFreyaAxe = new TFreyaAxe("ne");
			freya2.position = chessboard.getSquare("h1").position;
			chessboard.addChild(freya2);
			freya2.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
			{
				var s:AnimatedSprite = e.target as AnimatedSprite;
				s.show();
				s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					s.moveTo("ne");
				});
			});
			
			var axestan:AxeStanShield = new AxeStanShield("sw");
			axestan.position = chessboard.getSquare("a8").position;
			chessboard.addChild(axestan);
			axestan.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
			{
				var s:AnimatedSprite = e.target as AnimatedSprite;
				s.show();
				s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					s.moveTo("sw");
				});
			});
			
			var axestan2:AxeStanShield = new AxeStanShield("sw");
			axestan2.position = chessboard.getSquare("h8").position;
			chessboard.addChild(axestan2);
			axestan2.addEventListener(ConsilioEvent.ON_INITIALIZATION_COMPLETE, function(e:Event):void
			{
				var s:AnimatedSprite = e.target as AnimatedSprite;
				s.show();
				s.addEventListener(MouseEvent.CLICK, function(e:Event):void 
				{
					s.moveTo("sw");
				});
			});
		}
	}
}