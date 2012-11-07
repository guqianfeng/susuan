package com.renren.graph.core {
	
	import com.adobe.crypto.MD5;
	import com.renren.graph.conf.RenRenConfig;
	
	import flash.net.LocalConnection;
	
	public class RenRenXD {
		
		private var localConnection:LocalConnection;
		
		//callback函数格式callback(RenRenXD)
		private var callback:Function;
		
		private var redirectURI:String;
		
		public var data:Object;
		
		//构造一个RenRenXD对象
		public function RenRenXD(callback:Function = null) {
			this.callback = callback;
			var localConnectionId:String = openLocalConnection();
			this.redirectURI = RenRenConfig.REDIRECT_URI + "#transport=flash&origin=" + localConnectionId;
			
		}
		
		public function getRedirectURI():String {
			return redirectURI;
		}
		
		public function setCallback(callback:Function):void {
			this.callback = callback;
		}
		
		//JS SDK的transport=flash模式下，回调函数名称为recv，因此本函数命名为recv
		public function recv(result:Object, 
							   origin:String):void {
			this.data = result;
			callback(this);
		}
		
		public function close():void {
			closeLocalConnection();
		}
		
		private function openLocalConnection():String {
			localConnection = new LocalConnection();
			var localConnectionId:String =  "http://" + localConnection.domain + "/" + generateLocalConnectionId();
			localConnection.client = this;
			localConnection.connect(encodeURIComponent(localConnectionId));
			localConnection.allowDomain(RenRenConfig.WIDGET_DOMAIN);
			return localConnectionId;
		}
		
		private function generateLocalConnectionId():String {
			return (Math.random() * (1 << 30)).toString(36).replace('.', '');
		}
		
		private function closeLocalConnection():void {
			try {
				localConnection.close();
			} catch (e:*) { }
			
			localConnection = null;
		}
	}
}