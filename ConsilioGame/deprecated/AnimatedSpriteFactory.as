package de.bht.consilio.util
{
	
	import de.bht.consilio.model.anim.AnimatedSprite;
	import de.bht.consilio.model.anim.Animation;
	import de.bht.consilio.model.anim.AnimationData;
	import de.bht.consilio.model.anim.ConsilioEvent;
	import de.bht.consilio.model.anim.Frame;
	import de.bht.consilio.model.board.Board;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.osflash.thunderbolt.Logger;
	
	public class AnimatedSpriteFactory extends EventDispatcher
	{
		private static var PIECE_DESCRIPTIONS_LOCATION = "sprite_sheets/";
		private static var SPRITE_SHEETS_LOCATION = "sprite_sheets/";
		private static var SPRITE_SHEET_DESCRIPTIONS_LOCATION = "sprite_sheet_descriptions/";
		
		
		public function createAnimatedSpriteFromJsonDescription(baseUrl:String, spriteData:Object, facing:String, boardPosition:String) : void {
			
			var name:String = spriteData.name;
			
			var animationsToLoad:Array = spriteData.animations as Array;
			var animationsLeftToLoad:uint = 0;
			var animations:Dictionary = new Dictionary();
			
			var result:AnimatedSprite = new AnimatedSprite(animations, 55, 65, 96, facing, boardPosition, "stopped");
			
			for (var i:int = 0; i < animationsToLoad.length; i++) {
				
				animationsLeftToLoad++;
				
				var locations:Array = new Array();
				
				for(var j:int = animationsToLoad[i].numberOfFrames-1; j >= 0; j--)
				{
					if(j<10){
						locations.push(baseUrl + spriteData.name + "/" + animationsToLoad[i].name + "000" + j + ".png");
						Logger.log(Logger.INFO, baseUrl + spriteData.name + "/" + animationsToLoad[i].name + "000" + j + ".png");
					} else {
						locations.push(baseUrl + spriteData.name + "/" + animationsToLoad[i].name + "00" + j + ".png");
					}
				}
				
				var key:String = animationsToLoad[i].name;
				
				var data:Array = [animationsToLoad[i].animationdelay, animationsToLoad[i].numberOfFrames];
				
				var loader:ResourceLoader = new ResourceLoader(key, data);
				loader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, function(e:Event):void {
					animationsLeftToLoad--
					
					var loader:ResourceLoader = e.target as ResourceLoader;
					animations[loader.getKey()] = new Animation(loader.getLastResult(), loader.getData() as Array);
					if(animationsLeftToLoad < 1)
					{
						result.init("walking " + facing);
						
						dispatchEvent(new AnimatedSpriteFactoryEvent(AnimatedSpriteFactoryEvent.ON_SPRITE_CLOAD_COMPLETE, result));
					}
				});
				
				loader.loadImages(locations);
			}
		}

		public function createPieces(board:Board, boardData:Object):void 
		{

		}
		
		private function createAnimatedSprite(pieceDescription:Object, facing:String, boardPosition:String):AnimatedSprite 
		{
			
			var name:String = pieceDescription.name;
			
			var animationData:Dictionary;
			
			var spriteSheet:BitmapData;
			
			// load AnimationData
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(SPRITE_SHEET_DESCRIPTIONS_LOCATION + pieceDescription.animationData);
			
			loader.addEventListener(Event.COMPLETE, function(e:Event):void {
				
				var json:String = e.target.data;
				var result:Object = JSON.parse(json);
				
				var frames:Array = result.frames as Array;
				
				animationData = createAnimationData(frames);
				
			});
			
			loader.load(request);
			
			// Load Sprite Sheet			
			var imageLoader:Loader = new Loader();
			
			var urlRequest:URLRequest = new URLRequest();
			
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void{
				spriteSheet = e.target.content.bitmapData;
			});
			
			imageLoader.load(urlRequest);
			
			return null;
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
	}
}