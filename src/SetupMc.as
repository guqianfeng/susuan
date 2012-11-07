package src 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import fl.controls.CheckBox;
	import fl.controls.TextInput;
	/**
	 * ...
	 * @author JackyGu
	 */
	public class SetupMc extends Sprite{
		
		public function SetupMc() {
			loaddata();
			MovieClip(this.getChildByName("btnConfirm")).addEventListener(MouseEvent.MOUSE_DOWN, onConfirmMouseDownHandler);
			MovieClip(this.getChildByName("btnCancel")).addEventListener(MouseEvent.MOUSE_DOWN, onBtnCancelClickHandler);
		}
		private function onConfirmMouseDownHandler(event:MouseEvent):void {
			//按下确认按钮
			savedata();
			this.visible = false;
			dispatchEvent(new Event("NEW_CONFIGDATA"));//向主类发送事件
		}
		private function onBtnCancelClickHandler(event:MouseEvent):void {
			this.visible = false;
			dispatchEvent(new Event("CONTINUE"));//向主类发送事件
		}
		public function savedata():void {
			//保存数据
			//blabla是自定义的字符串，本地存储文件会以它来命名。 
			var so:SharedObject = SharedObject.getLocal("suansu"); 
			so.data.type1 = CheckBox(this.type1).selected?1:0;
			so.data.type2 = CheckBox(this.type2).selected?1:0;
			so.data.type3 = CheckBox(this.type3).selected?1:0;
			so.data.type4 = CheckBox(this.type4).selected?1:0;
			so.data.type5 = CheckBox(this.type5).selected?1:0;
			so.data.type6 = CheckBox(this.type6).selected?1:0;
			so.data.type7 = CheckBox(this.type7).selected?1:0;
			//so.data.type8 = CheckBox(this.type8).selected?1:0;
			so.data.voice = CheckBox(this.voice).selected?1:0;
			trace("===" + so.data.voice);
			so.flush();
		}
		public function loaddata():Object {
			var so:SharedObject = SharedObject.getLocal("suansu"); 
			if (so == null) {
				if (!so.data.type1) so.data.type1 = 1;//默认
				if (!so.data.type2) so.data.type2 = 1;//默认
				if (!so.data.type3) so.data.type3 = 0;//默认
				if (!so.data.type4) so.data.type4 = 0;//默认
				if (!so.data.type5) so.data.type5 = 0;//默认
				if (!so.data.type6) so.data.type6 = 0;//默认
				if (!so.data.type7) so.data.type7 = 0;//默认
				//if (!so.data.type8) so.data.type8 = 0;//默认
				if (!so.data.voice) so.data.voice = 1;//默认打开声音
			}
			CheckBox(this.type1).selected = so.data.type1 == 1?true:false;
			CheckBox(this.type2).selected = so.data.type2 == 1?true:false;
			CheckBox(this.type3).selected = so.data.type3 == 1?true:false;
			CheckBox(this.type4).selected = so.data.type4 == 1?true:false;
			CheckBox(this.type5).selected = so.data.type5 == 1?true:false;
			CheckBox(this.type6).selected = so.data.type6 == 1?true:false;
			CheckBox(this.type7).selected = so.data.type7 == 1?true:false;
			//CheckBox(this.type8).selected = so.data.type8 == 1?true:false;
			CheckBox(this.voice).selected = so.data.voice == 1?true:false;
			return so.data;
		}
	}
}