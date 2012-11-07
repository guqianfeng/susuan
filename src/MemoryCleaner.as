package src
{
	import flash.display.Bitmap;
	import flash.display.Sprite
	import flash.events.MouseEvent;
	import flash.net.LocalConnection;
	//import de.polygonal.ds.Array2;
	import flash.display.DisplayObject;
	
	/**垃圾回收工具
	 * ...
	 * @author ...
	 */
	public class MemoryCleaner{
		public static function removeMc(container:Sprite, mc:Sprite):void {
			if (mc) {
				var n1:int = mc.numChildren;
				if (n1 >= 1){
					for (var i1:int = n1 - 1; i1 >= 0; i1--) {
						delete mc.getChildAt(i1);
						mc.removeChildAt(i1);
					}
				}
				container.removeChild(mc);
				mc = null;
			}
		}
		public static function removeArray(arr:Array):void{
			for(var i:int = 0; i < arr.length; i++){
				delete arr[i];
			}
			arr = null;
		}
		/*
		public static function removeArray2(arr:Array2):void{
			for (var i:int = 0; i < arr.height; i++){
				for (var j:int = 0; j < arr.width; j++){
					delete arr.get(j, i);
				}
			}
			arr = null;
		}
		*/
		public static function clean():void{
			try{
				new LocalConnection().connect("fuckyou");
				new LocalConnection().connect("fuckyou");
			}
			catch(error : Error){
			} 
		}
	}
}