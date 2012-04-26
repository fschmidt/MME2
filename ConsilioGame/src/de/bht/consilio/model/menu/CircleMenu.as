package de.bht.consilio.model.menu
{
	import de.bht.consilio.model.anim.ConsilioEvent;
	import de.bht.consilio.model.iso.IsoObject;
	import de.bht.consilio.util.ResourceLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Point;

	public class CircleMenu extends IsoObject
	{
		private var bm:Bitmap;
		private var menuItems:Array = new Array();
		
		public function CircleMenu(size:uint)
		{
			super(size);
			this.height = size;
			this.width = size;
			
			init();
		}
		private function init():void
		{
			var loader:ResourceLoader = new ResourceLoader();
			loader.addEventListener(ConsilioEvent.ON_RESOURCE_LOAD_COMPLETE, function(e:Event):void {
				var loader:ResourceLoader = e.target as ResourceLoader;
				bm = (loader.getLastResult()[0]) as Bitmap;
				
				for (var i:int = 0; i < 4; i++) 
				{
					var s:Bitmap = new Bitmap();
					s.bitmapData = new BitmapData(bm.width, bm.height);
					s.bitmapData.copyPixels(bm.bitmapData, bm.bitmapData.rect, new Point(0, 0));
					menuItems.push(s);
				}
			
				(menuItems[0] as Bitmap).x = 43;
				(menuItems[0] as Bitmap).y = 0;
				
				(menuItems[1] as Bitmap).x = 86;
				(menuItems[1] as Bitmap).y = 43;
				
				(menuItems[2] as Bitmap).x = 43;
				(menuItems[2] as Bitmap).y = 86;
				
				(menuItems[3] as Bitmap).x = 0;
				(menuItems[3] as Bitmap).y = 43;
				
				addChild((menuItems[0] as Bitmap));
				addChild((menuItems[1] as Bitmap));
				addChild((menuItems[2] as Bitmap));
				addChild((menuItems[3] as Bitmap));
				
			});
			
			loader.loadImages(["img/general_icons/shoe.png"]);
		}
	}
}