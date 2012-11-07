package com.renren.graph.core {
	
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
	
	public class RenRenWidget {
		
		protected var renRenJS:RenRenJS;
		
		//字典结构，把一个RenRenXD实例唯一的标识redirectURI和它所对应的回调函数和widget信息对应起来
		//方便回调时重新获取
		private var openWidgets:Dictionary;
		
		public function RenRenWidget() {
			renRenJS = new RenRenJS();
			openWidgets = new Dictionary();
		}
		
		public function isReady():Boolean {
			return renRenJS.isReady();
		}
		
		public function open(widget:String,
							   options:Object = null,
							   callback:Function = null):void {
			
			if(options == null) {
				options = new Object();
			}
			options.url = widget;
			//options.onFailure = handleUIResponseFromJSSDK;
			var widgetId:String = widget + '#' + generateId();
			if(ExternalInterface.available) {
				ExternalInterface.addCallback('handleUI', handleUIResponseFromJSSDK);
				var origin:String = ExternalInterface.call('RenRenJSBridge.ui', options, widgetId);
				openWidgets[widgetId] = {widget:widget, callback:callback};
			}
			
		}
		
		/*public function close(xdId:String):void {
			if(ExternalInterface.available) {
				ExternalInterface.call('RenRenJSBridge.closeUI', xdId);
			}
		}
		
		//处理通过RenRenXD获得的信息
		private function handleUIResponseFromXD(xd:RenRenXD):void {
			//通知JS SDK关闭窗口
			close(xd.getId());
			trace("From AS XD：");
			for(var n:String in xd.data) {
				trace(n + ": " + xd.data[n]);
			}
			//准备回调
			execCallBack(xd.getId(), xd.data);
			
		}*/
		
		//用于从JS SDK回调，获得从LocalConnection中不能获得的信息，比如窗口关闭
		private function handleUIResponseFromJSSDK(response:Object, widgetId:String) : void {
			trace("From JS SDK：");
			for(var n:String in response) {
				trace(n + ": " + response[n]);
			}
			//准备回调
			execCallBack(widgetId, response);
		}
		
		private function execCallBack(widgetId:String, data:Object):void {
			var success:Boolean = true;
			if(data.error != null) {
				success = false;
			}
			var widget:String = openWidgets[widgetId]["widget"];
			var callback:Function = openWidgets[widgetId]["callback"];
			callback(success, data, widget);
			
			delete openWidgets[widgetId];
		}
		
		private function generateId():String {
			return (Math.random() * (1 << 30)).toString(36).replace('.', '');
		}
	}
}