package src 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author JackyGu
	 */
	public class Log extends Sprite
	{
		
		public function Log() {
			
		}
		public function message(txt:String):void {
			var txtField:TextField = this.getChildByName("txt") as TextField;
			txtField.text = txt + "\n" + txtField.text;
			trace(txt);
		}
	}

}