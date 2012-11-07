package com.renren.graph.data {
	
	import com.adobe.serialization.json.JSON;
	
	public class RenRenSession {
		
		public var accessToken:String;
		
		public var scope:String;
		
		public var sessionKey:String;
		
		public var sessionSecret:String;
		
		public var expiresIn:String;
		
		public var userId:String;
		
		public function RenRenSession() {
			
		}
		
		public function fromJSON(result:Object):void {
			if (result != null) {
				accessToken = result.accessToken;
				scope = result.scope;
				sessionKey = result.sessionKey;
				sessionSecret = result.sessionSecret;
				expiresIn = result.expiresIn;
				userId = result.userId;
			}
		}
		
		public function toString():String {
			return JSON.encode(this);
		}
	}
}