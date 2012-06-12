package de.bht.consilio.anim
{
	import avmplus.getQualifiedClassName;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import mx.core.ClassFactory;
	
	public class SpriteSheets
	{
		
		private static var instance:SpriteSheets;
		
		private var _sheets:Dictionary = new Dictionary();
		
		private var _descriptions:Dictionary = new Dictionary();
		
		public static function getInstance():SpriteSheets {
			if (instance == null) {
				instance = new SpriteSheets(new SingletonBlocker());
			}
			return instance;
		}
		
		public function SpriteSheets(p_key:SingletonBlocker):void {
			if (p_key == null) {
				throw new Error("Error: Instantiation failed: Use Singleton.getInstance() instead of new.");
			} 
		}
		
		
		public function sheetForName(name:String):Bitmap {
			return new (getClassForName(name)) as Bitmap;
		}
		
		public function descriptionForName(name:String):Object {
			var ba : ByteArray = new (getClassForName(name + "_desc")) as ByteArray;
			return JSON.parse(ba.readUTFBytes(ba.length));
		}
		
		public function animationDataForName(name:String):Object {
			var ba : ByteArray = new (getClassForName(name + "_animdata")) as ByteArray;
			return JSON.parse(ba.readUTFBytes(ba.length));
		}
		
		private function getClassForName(name:String):Class {
			return getDefinitionByName("de.bht.consilio.anim::SpriteSheets_" + name) as Class;
		}
		
		
		
		[Embed(source="img/sprite_sheets/axestan_shield.png")]
		[Bindable]
		public var axestan_shield:Class;
		
		[Embed(source="descriptions/piece_descriptions/axestan_shield.json", mimeType="application/octet-stream")]
		[Bindable]
		private var axestan_shield_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/axestan_shieldAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var axestan_shield_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/bjorn.png")]
		[Bindable]
		public var bjorn:Class;
		
		[Embed(source="descriptions/piece_descriptions/bjorn.json", mimeType="application/octet-stream")]
		[Bindable]
		private var bjorn_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/bjornAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var bjorn_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/black_knight.png")]
		[Bindable]
		public var black_knight:Class;
		
		[Embed(source="descriptions/piece_descriptions/black_knight.json", mimeType="application/octet-stream")]
		[Bindable]
		private var black_knight_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/black_knightAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var black_knight_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/black_mage.png")]
		[Bindable]
		public var black_mage:Class;
		
		[Embed(source="descriptions/piece_descriptions/black_mage.json", mimeType="application/octet-stream")]
		[Bindable]
		private var black_mage_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/black_mageAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var black_mage_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/dark_princess.png")]
		[Bindable]
		public var dark_princess:Class;
		
		[Embed(source="descriptions/piece_descriptions/dark_princess.json", mimeType="application/octet-stream")]
		[Bindable]
		private var dark_princess_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/dark_princessAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var dark_princess_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/fullplated_knight.png")]
		[Bindable]
		public var fullplated_knight:Class;
		
		[Embed(source="descriptions/piece_descriptions/fullplated_knight.json", mimeType="application/octet-stream")]
		[Bindable]
		private var fullplated_knight_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/fullplated_knightAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var fullplated_knight_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/greendwarf.png")]
		[Bindable]
		public var greendwarf:Class;
		
		[Embed(source="descriptions/piece_descriptions/greendwarf.json", mimeType="application/octet-stream")]
		[Bindable]
		private var greendwarf_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/greendwarfAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var greendwarf_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/hunter.png")]
		[Bindable]
		public var hunter:Class;
		
		[Embed(source="descriptions/piece_descriptions/hunter.json", mimeType="application/octet-stream")]
		[Bindable]
		private var hunter_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/hunterAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var hunter_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/queen.png")]
		[Bindable]
		public var queen:Class;
		
		[Embed(source="descriptions/piece_descriptions/queen.json", mimeType="application/octet-stream")]
		[Bindable]
		private var queen_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/queenAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var queen_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/red_archer.png")]
		[Bindable]
		public var red_archer:Class;
		
		[Embed(source="descriptions/piece_descriptions/red_archer.json", mimeType="application/octet-stream")]
		[Bindable]
		private var red_archer_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/red_archerAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var red_archer_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/red_knight.png")]
		[Bindable]
		public var red_knight:Class;
		
		[Embed(source="descriptions/piece_descriptions/red_knight.json", mimeType="application/octet-stream")]
		[Bindable]
		private var red_knight_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/red_knightAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var red_knight_animdata : Class;
		
		
		
		[Embed(source="img/sprite_sheets/white_mage.png")]
		[Bindable]
		public var white_mage:Class;
		
		[Embed(source="descriptions/piece_descriptions/white_mage.json", mimeType="application/octet-stream")]
		[Bindable]
		private var white_mage_desc : Class;
		
		[Embed(source="descriptions/sprite_sheet_descriptions/white_mageAnimationData.json", mimeType="application/octet-stream")]
		[Bindable]
		private var white_mage_animdata : Class;
		
	}
}

internal class SingletonBlocker {}