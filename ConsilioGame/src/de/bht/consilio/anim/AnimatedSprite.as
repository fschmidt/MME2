package de.bht.consilio.anim
{
	import de.bht.consilio.iso.IsoObject;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.utils.Dictionary;
	
	public class AnimatedSprite extends IsoObject
	{
		private static var PIECE_DESCRIPTIONS_LOCATION:String = "descriptions/piece_descriptions/";
		private static var SPRITE_SHEET_DESCRIPTIONS_LOCATION:String = "descriptions/sprite_sheet_descriptions/";
		
		private static var spriteSheets:Dictionary = new Dictionary();
		
		private static var numberOfSpriteSheets:uint = 0;
		
		private var _pieceDescription:Object;
		
		private var _animationData:Dictionary;
		
		private var _animationOffsetContainer:Sprite = new Sprite();
		
		private var _currentAnimation:AnimationData;
		
		private var _currentFrame:Bitmap;
		
		private var _animationIndex:uint = 0;
		
		private var _currentFrameIndex:uint = 0;
		
		private var _facing:String;
		
		private var _boardPosition:String;
		
		public function AnimatedSprite(name:String, boardPosition:String, facing:String)
		{
			super(0);
			
			_facing = facing;
			_boardPosition = boardPosition;
			this.name = name;
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			init();
		}
		
		public function init():void {
			
			var myRequest:URLRequest = new URLRequest(PIECE_DESCRIPTIONS_LOCATION + name + ".json");
			var myLoader:URLLoader = new URLLoader();
			
			myLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
				_pieceDescription = JSON.parse(e.target.data);
				
				_animationOffsetContainer.x = - _pieceDescription.xoffset;
				_animationOffsetContainer.y = - _pieceDescription.yoffset;
				
				// load AnimationData
				var loader:URLLoader = new URLLoader();
				var request:URLRequest = new URLRequest(SPRITE_SHEET_DESCRIPTIONS_LOCATION + _pieceDescription.animationData);
				
				loader.addEventListener(Event.COMPLETE, function(e:Event):void 
				{
					
					e.currentTarget.removeEventListener( e.type, arguments.callee );
					
					var json:String = e.target.data;
					var result:Object = JSON.parse(json);
					
					
					var frames:Array = result.frames as Array;
					
					_animationData = createAnimationData(frames);
				
					onInitializationComplete();
					
				});
				
				loader.load(request);
				
			});
			myLoader.load(myRequest);
			
		}
		
		private function onInitializationComplete():void
		{
			
			_currentAnimation = _animationData["walking " + _facing];
			
			var f:Frame = _currentAnimation.frames[0];
			
			_currentFrame = new Bitmap();
			
			_currentFrame.bitmapData = new BitmapData(f.w, f.h);
			
			trace("Memory used before accessing sheet: " + Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "Mb");
			
			trace(name);

			_currentFrame.bitmapData.copyPixels(spriteSheets[name + ".png"], new Rectangle(f.x, f.y, f.w, f.h), new Point(0, 0));

			trace("Memory used before accessing sheet: " + Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "Mb");

//			trace("Rect: " + new Rectangle(f.x, f.y, f.w, f.h));
			
//			trace("Memory used: " + Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "Mb");
			
			_animationOffsetContainer.addChild(_currentFrame);
			
			addChild(_animationOffsetContainer);
		}
		
		/**
		 * Creates a dictionary containing AnimationData Objects for each Animation in the given Array. 
		 * 
		 * @param input Array loaded from the JSON description of the AnimatedSprite
		 * @return Dictionary containing AnimationData Objects
		 * 
		 */
		private function createAnimationData(input:Array):Dictionary {
			var result:Dictionary = new Dictionary();
			
			for (var i:int = 0; i < input.length; i++) 
			{
				var current:Object = input[i];
				
				var currentFrameName:String = current.filename as String;
				
				var currentPattern:String = currentFrameName.split("/")[0];
				
				if(!result.hasOwnProperty(currentPattern)){
					result[currentPattern] = new AnimationData();
				}
				
				var f:Frame = new Frame(current.frame.x, current.frame.y, current.frame.w, current.frame.h);
				
				(result[currentPattern] as AnimationData).frames.push(f);
			}
			return result;
		}
		
		public function startCurrentAnimation():void
		{
			addEventListener(Event.ENTER_FRAME, animate);
		}
		
		public function stopCurrentAnimation():void
		{
			removeEventListener(Event.ENTER_FRAME, animate);
		}
		
		private function animate(e:Event):void {
			_animationIndex++;
			
			if(_animationIndex >= 5) {
				_animationIndex = 0;
				
				if(_currentFrameIndex >= _currentAnimation.frames.length-1)
				{
					_currentFrameIndex = 0;
				} 
				else 
				{
					_currentFrameIndex++;
				}
				
				var f:Frame = _currentAnimation.frames[_currentFrameIndex];
				
				_currentFrame.bitmapData.copyPixels(spriteSheets[name + ".png"], new Rectangle(f.x, f.y, f.w, f.h), new Point(0, 0));
				
				trace("Memory used: " + Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "Mb");
			}			
		}
		
		public function show():void
		{
			_animationOffsetContainer.addChild(_currentFrame);
		}
		
		public function hide():void
		{
			_animationOffsetContainer.removeChild(_currentFrame);
		}
		
		public function set boardPosition(newPosition:String):void {
			_boardPosition = newPosition;
		}
		public function get boardPosition():String {
			return _boardPosition;
		}
		
		public static function addSpriteSheet(name:String, sheet:BitmapData):void
		{
			spriteSheets[name] = sheet;
		}
	}
}