package de.bht.consilio.application
{
	import de.bht.consilio.custom_components.view.ActionMenu;
	import de.bht.consilio.custom_components.view.BottomMenu;
	import de.bht.consilio.custom_components.view.GameStatusBar;
	import de.bht.consilio.game.ConsilioGame;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.System;
	
	import mx.events.FlexEvent;
	
	import spark.components.BorderContainer;
	import spark.components.BusyIndicator;
	import spark.components.Label;
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
		
		public var gameStatusBar:GameStatusBar;
		
		public var busyIndicator:BusyIndicator;
		
		public var busyLabel:Label;
		
		private var _userId:String;
		
		private var _opponentId:String;
		
		private var _gameName:String;
		
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
			showBusyIndicator("Waiting for another Player to join.");
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
		
		public function showBusyIndicator(text:String):void {
			busyIndicator.enabled = true;
			busyIndicator.visible = true;
			busyLabel.text = text;
			busyLabel.enabled = true;
			busyLabel.visible = true;
		}
		
		public function disableBusyIndicator():void {
			busyIndicator.enabled = false;
			busyIndicator.visible = false;
			busyLabel.enabled = false;
			busyLabel.visible = false;
		}
		
		public function updateStatusBar(powerWhite:uint, powerBlack:uint, turn:uint):void {
			gameStatusBar.updateStatusBar(powerWhite, powerBlack, turn);
		}
		
		public function initStatusBar(nameWhite:String, nameBlack:String, powerWhite:uint, powerBlack:uint, turn:uint):void {
			gameStatusBar.initStatusBar(_gameName, nameWhite, nameBlack, powerWhite, powerBlack, turn);
		}
		
		public function getUserId():String {
			return _userId;
		}
		
		public function setUserId(userId:String):void {
			_userId = userId;
		}
		
		public function getOpponentId():String {
			return _opponentId;
		}
		
		public function setOpponentId(opponentId:String):void {
			_opponentId = opponentId;
		}
		
		public function setGameName(s:String):void {
			_gameName = s;
		}
	}
}