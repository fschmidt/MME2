package application {
	import flash.events.MouseEvent;
	
	import game.ConsilioGame;
	
	import mx.containers.Panel;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.components.Button;

	public class ConsilioApp extends Application {
		public var mainPanel:Panel; //has to be public
		
		public function ConsilioApp() {
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		private function creationCompleteHandler (event:FlexEvent):void {
			mainPanel.addChild(new ConsilioGame());
		}
	}
}