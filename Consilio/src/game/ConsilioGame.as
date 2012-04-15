package game{
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.scene.IsoScene;
	
	import flash.display.MovieClip;
	
	public class ConsilioGame extends MovieClip{ 
		
		private var box:IsoBox = new IsoBox();
		private var scene:IsoScene = new IsoScene();
		
		public function ConsolioGame():void {
			renderGame();
		}
		
		private function renderGame():void
		{
			box.setSize(25, 25, 25);
			box.moveTo(200, 0, 0);
			
			scene.hostContainer = this;
			scene.addChild(box);
			scene.render();
			
		}
	}
}