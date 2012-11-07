package com.renren.graph.core {
	
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONParseError;
	import com.renren.graph.conf.AppConfig;
	import com.renren.graph.conf.RenRenConfig;
	import com.renren.graph.data.RenRenSession;
	import com.renren.graph.net.RenRenRequest;
	
	import flash.external.ExternalInterface;
	import flash.net.URLVariables;
	import flash.system.Security;
	
	public class RenRenAuth {

		private var session:RenRenSession;
		
		private var callback:Function;
		
		private var useWidget:Boolean;
		
		private var renRenWidget:RenRenWidget;
		
		private var renRenXD:RenRenXD;
		
		public function RenRenAuth(callback:Function) {
			session = new RenRenSession();
			this.callback = callback;
			renRenWidget = new RenRenWidget();
			//判断JS SDK是否存在，存在就是用JS SDK调用Widget
			useWidget = renRenWidget.isReady();
			//如果不存在,用Flash自己来弹窗口
			if(!useWidget) {
				if(ExternalInterface.available) {
					ExternalInterface.call(AuthWindowJS);
				}
			}
		}
		
		//弹出验证窗口
		public function auth(display:String = "popup", scope:String = null):void {
			if(useWidget) {
				authViaWidget(display, scope);
			} else {
				authViaWindow(scope);
			}
			
			/*if(ExternalInterface.available) {
				ExternalInterface.call("AuthWindow.open", url);
			}*/
			/*var params:Object = {
				client_id : AppConfig.API_KEY,
				response_type : 'token'
			};
			if(scope != null && scope != "") {
				params.scope = scope;
			}
			var options:Object = {display:'popup', params:params};
			renRenWidget.open(RenRenConfig.OAUTH_AUTH_URL, options, handleAccessTokenLoad);*/
			/*if(ExternalInterface.available) {
				ExternalInterface.addCallback('handleUI', null);
				ExternalInterface.call('RenRenJSBridge.ui', options, xd.getId());
			}*/
			
		}
		
		private function authViaWindow(scope:String = null):void {
			//当要通过弹窗来进行授权的时候初始化RenRenXD
			renRenXD = new RenRenXD(handleResponseFromXD);
			var url:String = RenRenConfig.OAUTH_AUTH_URL + 
				"?client_id=" + encodeURIComponent(AppConfig.API_KEY) + 
				"&response_type=token" + 
				"&redirect_uri=" + encodeURIComponent(renRenXD.getRedirectURI());
			
			if(ExternalInterface.available) {
				ExternalInterface.call("AuthWindow.open", url);
			}
		}
		
		//authViaWindow对应的回调函数
		private function handleResponseFromXD(renRenXD:RenRenXD):void {
			var data:Object = renRenXD.data;
			
			if(data.error != null) {
				callback(false, {error:"auth_error", error_code:data.error, error_message:data.error_description});
			} else {
				session.accessToken = data["access_token"];
				session.expiresIn = data["expires_in"];
				session.scope = data["scope"];
				loadSessionKey();
			}
			
			if(ExternalInterface.available) {
				ExternalInterface.call('AuthWindow.close');
			}
		}
		
		private function authViaWidget(display:String = "popup", scope:String = null):void {
			var params:Object = {
				client_id : AppConfig.API_KEY,
				response_type : 'token'
			};
			if(scope != null && scope != "") {
				params.scope = scope;
			}
			var options:Object = {display:display, params:params};
			renRenWidget.open(RenRenConfig.OAUTH_AUTH_URL, options, handleResponseFromWidget);
		}
		
		//authViaWidget对应的回调函数
		private function handleResponseFromWidget(success:Boolean, 
													data:Object, 
													widget:String):void {
			if(success) {
				session.accessToken = data["access_token"];
				var expiresIn:String = data["expires_in"];
				var currentDate:Date  = new Date();
				var expireDate:Date = new Date(currentDate.getTime() + parseInt(expiresIn, 10) * 1000);
				session.expiresIn = expireDate.toString();
				session.scope = data["scope"];
				loadSessionKey();
			} else {
				callback(false, {error:"auth_error", error_code:data.error, error_message:data.error_description});
			}
		}
		/*public function auth(scope:String = null):void {
			var url:String = RenRenConfig.OAUTH_TRY_URL + "?api_key=" + AppConfig.API_KEY + 
				"&redirect_uri=" + encodeURIComponent(xd.getRedirectURI());
			
			var options:Object = {url:url, display:'hidden'};
			if(ExternalInterface.available) {
				ExternalInterface.addCallback('handleUI', null);
				ExternalInterface.call('RenRenJSBridge.ui', options, xd.getId());
			}
		}*/
		
		//尝试获得当前登录用户已经授权的access_token
		//只有引入了JS SDK才可以使用
		public function tryToGetToken():void {
			var params:Object = {
				client_id : AppConfig.API_KEY,
				response_type : 'token'
			};
			var options:Object = {display:'hidden', params:params};
			renRenWidget.open(RenRenConfig.OAUTH_AUTH_URL, options, handleResponseFromWidget);
		}
		
		//用access_token获得session_key
		private function loadSessionKey():void {
			var request:RenRenRequest = new RenRenRequest();
			Security.loadPolicyFile(RenRenConfig.API_SESSION_KEY_POLICY_FILE_URL);
			request.send(RenRenConfig.API_SESSION_KEY_URL, {oauth_token:session.accessToken}, handleSessionKeyLoad);
		}
		
		//获得session_key会回调此函数
		private function handleSessionKeyLoad(request:RenRenRequest):void {
			if(request.success) {
				try {
					var data:Object = JSON.decode(request.data as String);
					if(data.error != null) {
						callback(false, {error:"auth_error", error_code:data.error, error_message:data.error_description});
					} else {
						session.sessionKey = data["renren_token"]["session_key"];
						session.sessionSecret =data["renren_token"]["session_secret"];
						session.userId = data["user"]["id"];
						callback(true, session);
					}
				} catch(e:JSONParseError) {
					callback(false, {error:"json_decode_error", error_message:e.text});
				}
			} else {
				callback(false, request.data);
			}
		}
		
		private const AuthWindowJS:XML =
			<script>
				<![CDATA[
					function() {
						AuthWindow = {
							handler : null,	
				
							open:function(url){
								handler = window.open(url,'newwindow','height=420,width=500,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no, z-look=yes, alwaysRaised=yes');
							},
							
							close:function() {
								handler.close();
							}
						};
					}
				]]>
			</script>;
	}
}