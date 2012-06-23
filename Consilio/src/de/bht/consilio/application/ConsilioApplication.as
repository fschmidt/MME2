package de.bht.consilio.application
{
	import de.bht.consilio.custom_components.view.ActionMenu;
	import de.bht.consilio.custom_components.view.BottomMenu;
	import de.bht.consilio.game.ConsilioGame;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.System;
	
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
		 * The action menu 
		 */
		public var actionMenu:ActionMenu;
		/**
		 * The actual game  
		 */
		private var game:ConsilioGame;
		
		public function ConsilioApplication()
		{
			super();
			instance = this;
		}
		
		/**
		 * Instantiates the game once all mxml components are initialized
		 * 
		 * @param event the creationCompleteEvent
		 * 
		 */
		protected function initMainView(isWhitePlayer:Boolean):void
		{
			game = new ConsilioGame(isWhitePlayer);
			
//			uncomment for debugging memory usage
			trace("Memory used: " + Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "Mb");
			mainContainer.addElement(game);
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