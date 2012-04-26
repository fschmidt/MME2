package de.bht.consilio.game 
{
	import de.bht.consilio.model.AxeStanShield;
	import de.bht.consilio.model.BlackMage;
	import de.bht.consilio.model.DarkPrincess;
	import de.bht.consilio.model.Dwarf;
	import de.bht.consilio.model.TFreyaAxe;
	import de.bht.consilio.model.Vladsword;
	import de.bht.consilio.model.WhiteMage;
	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.board.Board;
	import de.bht.consilio.model.board.Square;
	import de.bht.consilio.model.menu.CircleMenu;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	[SWF(width="1024",height="768",frameRate="30", backgroundColor="0x000000")]
	public class ConsilioGame extends Sprite{
		
		private var mySprite:AnimatedSprite;
		private var mySprite2:AnimatedSprite;
		
		private var chessboard:Board;
		
		public function ConsilioGame(){
			init();
		}
		
		private function init():void
		{
			chessboard = new Board( 0x333333, 0x999999 );
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
				var s:Square = chessboard.getSquare(String.fromCharCode(64+i).toLowerCase()+"2");
				chessboard.addChild(dwarf);
			}
			
			for(var j:int = 1; j < 9; j++)
			{
				var vlad:Vladsword = new Vladsword("sw");
				vlad.position = chessboard.getSquare(String.fromCharCode(64+j).toLowerCase()+"7").position;
				chessboard.getSquare(String.fromCharCode(64+j).toLowerCase()+"7").registerSprite(vlad);
				chessboard.addChild(vlad);
			}
			
			var dprin:DarkPrincess = new DarkPrincess("sw");
			dprin.position = chessboard.getSquare("e8").position;
			chessboard.getSquare("e8").registerSprite(dprin);
			chessboard.addChild(dprin);
			
			var dprin2:DarkPrincess = new DarkPrincess("ne");
			dprin2.position = chessboard.getSquare("e1").position;
			chessboard.getSquare("e1").registerSprite(dprin2);
			chessboard.addChild(dprin2);
			
			var wmage:WhiteMage = new WhiteMage("ne");
			wmage.position = chessboard.getSquare("c1").position;
			chessboard.getSquare("c1").registerSprite(wmage);
			chessboard.addChild(wmage);
			
			var wmage2:WhiteMage = new WhiteMage("ne");
			wmage2.position = chessboard.getSquare("f1").position;
			chessboard.getSquare("f1").registerSprite(wmage2);
			chessboard.addChild(wmage2);
			
			var bmage:BlackMage = new BlackMage("sw");
			bmage.position = chessboard.getSquare("c8").position;
			chessboard.getSquare("c8").registerSprite(bmage);
			chessboard.addChild(bmage);
			
			var bmage2:BlackMage = new BlackMage("sw");
			bmage2.position = chessboard.getSquare("f8").position;
			chessboard.getSquare("f8").registerSprite(bmage2);
			chessboard.addChild(bmage2);
			
			var freya:TFreyaAxe = new TFreyaAxe("ne");
			freya.position = chessboard.getSquare("a1").position;
			chessboard.getSquare("a1").registerSprite(freya);
			chessboard.addChild(freya);
			
			var freya2:TFreyaAxe = new TFreyaAxe("ne");
			freya2.position = chessboard.getSquare("h1").position;
			chessboard.getSquare("h1").registerSprite(freya2);
			chessboard.addChild(freya2);
			
			var axestan:AxeStanShield = new AxeStanShield("sw");
			axestan.position = chessboard.getSquare("a8").position;
			chessboard.getSquare("a8").registerSprite(axestan);
			chessboard.addChild(axestan);
			
			
			var axestan2:AxeStanShield = new AxeStanShield("sw");
			axestan2.position = chessboard.getSquare("h8").position;
			chessboard.getSquare("h8").registerSprite(axestan2);
			chessboard.addChild(axestan2);
		}
	}
}