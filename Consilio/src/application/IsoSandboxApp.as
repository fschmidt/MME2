package application {
	import flash.events.MouseEvent;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.components.Button;

	public class IsoSandboxApp extends Application {
		public var myButton:Button; //has to be public
		
		public var isoHostContainer:UIComponent;
		
		public function IsoSandboxApp() {
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		private function creationCompleteHandler (event:FlexEvent):void {
			myButton.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}
		public function handleMouseUp(e:MouseEvent):void {

			
		}
	}
}