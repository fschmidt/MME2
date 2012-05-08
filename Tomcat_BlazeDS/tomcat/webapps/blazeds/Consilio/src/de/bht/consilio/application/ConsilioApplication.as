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
	
	
	/**
	 * Consilio Application class
	 *  
	 * @author Frank Schmidt
	 * 
	 */
	public class ConsilioApplication extends WindowedApplication
	{

		private static var instance:ConsilioApplication;
		
		/**
		 * The main container 
		 */
		public var mainContainer:BorderContainer; // Consilio.mxml reference
		/**
		 * The bottom menu 
		 */
		public var bottomMenu:BottomMenu;
		/**
		 * The actual game =) 
		 */
		private var game:ConsilioGame;
		
		public function ConsilioApplication()
		{
			super();
			instance = this;
//			addEventListener (FlexEvent.CREATION_COMPLETE, initMainView);
		}
		
		/**
		 * Instantiates the game once all mxml components are initialized
		 * 
		 * @param event the creationCompleteEvent
		 * 
		 */
		protected function initMainView():void
		{
			game = new ConsilioGame();
			mainContainer.addElement(game);
		}
		

		/**
		 * Sets an entry in the bottom menu
		 * 
		 * @param pic the pieces picture
		 * @param attackValue the pieces attack value
		 * @param defenseValue the pieces defense value
		 * @param moveValue the pieces moveValue
		 * @param moveTypeValue the pieces moce type (ie "diagonal")
		 * 
		 */
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
		
		/**
		 * 
		 * @return the current instance of the ConsilioApplication
		 * 
		 */
		public static function getInstance():ConsilioApplication
		{
			return instance;
		}
	}
}