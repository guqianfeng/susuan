package src 
{
	/**
	 * 数字键盘输入数字
	 * @author JackyGu
	 */
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class KeyInput extends Sprite{
		
		public function KeyInput() {
			Sprite(this.getChildByName("key0")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("key1")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("key2")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("key3")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("key4")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("key5")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("key6")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("key7")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("key8")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("key9")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("point")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
			Sprite(this.getChildByName("cancel")).addEventListener(MouseEvent.MOUSE_DOWN, onKeyPressHandler);
		}
		private function onKeyPressHandler(event:MouseEvent):void {
			var mc:Sprite = event.currentTarget as Sprite;
			var keyname:String = mc.name;
			var key:String;
			if (keyname.substr(0, 3) == "key") key = keyname.substr(3, 1);
			if (keyname == "point") key = ".";
			if (keyname == "cancel") key = "c";
			dispatchEvent(new myEvent(myEvent.KEY_DOWN, {input:key } ));
		}
	}
}