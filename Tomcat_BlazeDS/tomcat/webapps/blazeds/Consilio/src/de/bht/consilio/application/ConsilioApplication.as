package de.bht.consilio.application
{
	import de.bht.ConsilioCustomComponents.BottomMenu;
	import de.bht.consilio.game.ConsilioGame;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import spark.components.BorderContainer;
	import spark.components.WindowedApplication;
	import spark.core.SpriteVisualElement;
	
	
	public class ConsilioApplication extends WindowedApplication
	{

		private static var instance:ConsilioApplication;
		
		public var mainContainer:BorderContainer; // Consilio.mxml reference
		public var bottomMenu:BottomMenu;
		private var game:ConsilioGame;
		
		public function ConsilioApplication()
		{
			super();
			instance = this;
			addEventListener (FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		protected function creationCompleteHandler(event:Event):void
		{
			game = new ConsilioGame();
			mainContainer.addElement(game);
		}
		
		public function setMenuEntry(pic:Bitmap, attackValue:uint, defenseValue:uint, moveValue:uint, moveTypeValue:String):void
		{
			bottomMenu.attack_label.text = "" + attackValue;
			bottomMenu.defense_label.text = "" + defenseValue;
			bottomMenu.move_label.text = "" + moveValue;
			bottomMenu.move_type_label.text = moveTypeValue;
			var s:SpriteVisualElement = new SpriteVisualElement();
			s.addChild(pic);
			bottomMenu.imageContainer.addElement(s);
			bottomMenu.hp_bar.minimum = 0;
			bottomMenu.hp_bar.label = "HP: 2/5"
			bottomMenu.hp_bar.setProgress(2,5);
		}
		
		public static function getInstance():ConsilioApplication
		{
			return instance;
		}
	}
}