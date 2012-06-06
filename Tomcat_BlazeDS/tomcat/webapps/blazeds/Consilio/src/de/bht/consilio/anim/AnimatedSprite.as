package de.bht.consilio.anim
{
	import com.greensock.TweenLite;
	
	import de.bht.consilio.board.Square;
	import de.bht.consilio.iso.IsoObject;
	import de.bht.consilio.iso.IsoUtils;
	import de.bht.consilio.iso.Point3D;
	
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
	
	/**
	 * Class representing an Animated Sprite. Consilio pieces are all instances of this class
	 * 
	 * @author Frank Schmidt
	 * 
	 */
	public class AnimatedSprite extends IsoObject
	{
		private static var PIECE_DESCRIPTIONS_LOCATION:String = "descriptions/piece_descriptions/";
		private static var SPRITE_SHEET_DESCRIPTIONS_LOCATION:String = "descriptions/sprite_sheet_descriptions/";
		
		/**
		 * sprite sheets are stored in a static variable for efficient reuse 
		 */
		private static var spriteSheets:Dictionary = new Dictionary();
		
		private var _pieceDescription:Object;
		
		/**
		 * Dictionary storing animation information. Information for a specific animation is accessed by its name ie "walking ne" 
		 */
		private var _animationData:Dictionary;
		
		/**
		 * Container for correct offset positioning of the sprite. It's x and y attributes should be set in the constructor only. 
		 */
		private var _animationOffsetContainer:Sprite = new Sprite();
		
		private var _currentAnimation:AnimationData;
		
		private var _currentFrame:Bitmap;
		
		/**
		 * Used in animate function to check whether current frame has to be changed 
		 */
		private var _animationIndex:uint = 0;
		
		/**
		 * Used to determine the current frame of the current animation 
		 */
		private var _currentFrameIndex:uint = 0;
		
		/**
		 * The direction this piece is currently facing (ie "ne"). Used as suffix for setting animations. 
		 */
		private var _facing:String;
		
		/**
		 * This pieces current position on the board in chess notation (ie "a8") 
		 */
		private var _boardPosition:String;
		
		/**
		 * This pieces picture shown in the menu when it's selected 
		 */
		private var _picture:Bitmap;
		
		private var _party:uint;
		
		private var _maxLivePoints:uint = 5;
		private var _livePoints:uint = 5;
		
		public function AnimatedSprite(name:String, boardPosition:String, facing:String)
		{
			// since pieces are never scaled given size can be zero
			super(0);
			
			_facing = facing;
			_boardPosition = boardPosition;
			this.name = name;
			
			// selection is handled via squares so selection for pieces is disabled (too inaccurate)
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			init();
		}
		
		/**
		 * Loads this pieces description depending on the given name
		 * 
		 */
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
		
		/**
		 * Enables this piece and sets it's first animation
		 * 
		 */
		private function onInitializationComplete():void
		{
			
			_currentAnimation = _animationData["walking " + _facing];
			
			var f:Frame = _currentAnimation.frames[0];
			_currentFrame = new Bitmap();
			_currentFrame.bitmapData = new BitmapData(f.w, f.h);
			
			// uncomment for debugging memory usage
//			trace("Memory used before accessing sheet: " + Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "Mb");

			_currentFrame.bitmapData.copyPixels(spriteSheets[name + ".png"], new Rectangle(f.x, f.y, f.w, f.h), new Point(0, 0));
			
			f = _animationData["stopped"].frames[0];
			
			_picture = new Bitmap();
			_picture.bitmapData = new BitmapData(f.w, f.h);
			
			// copy the pixel data from the sprite sheet
			_picture.bitmapData.copyPixels(spriteSheets[name + ".png"], new Rectangle(f.x, f.y, f.w, f.h), new Point(0, 0));

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
		
		/**
		 * Starts the current animation
		 */
		public function startCurrentAnimation():void
		{
			addEventListener(Event.ENTER_FRAME, animate);
		}
		
		/**
		 * Stops the current animation
		 */
		public function stopCurrentAnimation():void
		{
			removeEventListener(Event.ENTER_FRAME, animate);
		}
		
		/**
		 * Rendering function. Called when this piece listens to OnEnterFrameEvents (startAnimation was called)
		 * 
		 * @param e OnEnterFrameEvent
		 * 
		 */
		private function animate(e:Event):void {
			_animationIndex++;
			
			if(_animationIndex >= 3) {
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
			}			
		}
		
		public function moveTo(s:Square):void
		{
			var screenPosition:Point = IsoUtils.isoToScreen(s.position);
			this.position = s.position;
//			trace(screenPosition);
//			trace("This x: " + this.x + ", This y: " + this.y + ", sq x: " + s.x + ", sq y: " + s.y);
//			TweenLite.to(this, 8, {x:this.x+60, y:this.y-30, onComplete:stopCurrentAnimation});
		}
		
		/**
		 * Make this piece visible
		 */
		public function show():void
		{
			_animationOffsetContainer.addChild(_currentFrame);
		}
		
		/**
		 * Make this piece invisible
		 */
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
		
		public function get picture():Bitmap {
			return _picture;
		}
		
		public function get facing():String {
			return _facing;
		}
		
		public function get maxLivePoints():uint {
			return _maxLivePoints;
		}
		
		public function get livePoints():uint {
			return _livePoints;
		}
		
		public function set livePoints(livePoints:uint):void {
			_livePoints = livePoints;
		}
		
		/**
		 * Adds a sprite sheet to the dictionary
		 * 
		 * @param name name of the piece
		 * @param sheet the bitmap data of the loaded sheet
		 * 
		 */
		public static function addSpriteSheet(name:String, sheet:BitmapData):void
		{
			spriteSheets[name] = sheet;
		}
	}
}