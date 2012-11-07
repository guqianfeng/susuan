package com.renren.graph.core {
	
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONParseError;
	import com.renren.graph.conf.AppConfig;
	import com.renren.graph.conf.RenRenConfig;
	import com.renren.graph.data.RenRenSession;
	import com.renren.graph.event.RenRenEvent;
	import com.renren.graph.net.RenRenRequest;
	
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	public class RenRenAPI {
		
		protected var session:RenRenSession;
		
		//为什么要弄一个字典在这里？
		//因为像回调函数这样的参数需要跨函数传递
		protected var openRequests:Dictionary;
		
		/**
		 * 构造函数，用一个RenRenSession的实例来初始化RenRenAPI<br/>
		 * 注意确保这个RenRenSession的实例确实是通过一个标准的流程获得的，否则在调用接口时会失败
		 */
		public function RenRenAPI(session:RenRenSession) {
			this.session = session;
			openRequests = new Dictionary();
		}
		
		/**
		 * call方法是调用人人网开放平台的REST API的一个通用的方法
		 * @param method REST API的大部分接口都要求一个method参数，表示调用哪个接口，例如users.getInfo
		 * 可以参考http://wiki.dev.renren.com/wiki/API看看现在支持哪些method
		 * @param params 调用REST API所需的其他参数
		 * @param callback 调用REST API所获得的结果通过这个回调函数传递，回调函数要求有以下形式：
		 * callback(success, data, method);<br/>
		 * success：类型为Boolean，表示接口是否调用成功了<br/>
		 * data：类型为Object，调用成功的话里面是接口返回的数据，失败的话里面是接口返回的错误信息，
		 * 错误信息结构为{error:xxx, message:yyy}<br/>
		 * method：类型是String，让回调的结果有一定的“自省性”，从这个参数可以获知是哪个接口返回的结果
		 */
		public function call(method:String,
							   params:Object = null,
							   callback:Function = null):void {
			for (var n:String in params) {
				if(params[n] == null || params[n] == "") {
					delete params[n];
				}
			}
			params.method = nullToEmptyString(method);
			appendParams(params);
			var request:RenRenRequest = new RenRenRequest();
			openRequests[request] = {method:method, callback:callback};
			//注意：计算sig的时候不需要对参数进行URLEncode（“application/x-www-form-urlencoded”编码）
			//但是发送请求的时候需要进行URLEncode,如果参数中有中文等不经过encode会提示签名出错
			//encodeParams(params);
			request.send(RenRenConfig.API_URL, params, handleRequestLoad);
		}
		
		private function appendParams(params:Object):void {
			params.format = "JSON";
			if(AppConfig.API_KEY != null && AppConfig.API_KEY != "")
				params.api_key = AppConfig.API_KEY;
			if(RenRenConfig.API_VERSION != null && RenRenConfig.API_VERSION != "")
				params.v = RenRenConfig.API_VERSION;
			if(session.sessionKey != null && session.sessionKey != "")
				params.session_key = session.sessionKey;
			/*if(session.accessToken != null && session.accessToken != "")
				params.access_token = session.accessToken;*/
			params.call_id = new Date().valueOf();
			//使用session_key需要带上这个参数，文档上没写
			params.xn_ss = "1";
			//最后添加签名参数
			params.sig = sig(params);
		}
		
		private function encodeParams(params:Object):void {
			for (var n:String in params) {
				if(params[n] != null) {
					//params[n] = escape(params[n]);
					params[n] = encodeURI(params[n]);
				}
			}
		}
		
		private function handleRequestLoad(request:RenRenRequest):void {
			var method:String = openRequests[request]["method"];
			var callback:Function = openRequests[request]["callback"];
			//回调函数的data参数在回调前做些处理
			//api_error,json_decode_error,io_error,security_error
			if(request.success) {
				try {
					var data:Object = JSON.decode(request.data as String);
					if(data.error_code != null) {
						callback(false, {error:"api_error", error_code:data.error_code, error_message:data.error_msg}, method);
					} else {
						callback(true, data, method);
					}
				} catch(e:JSONParseError) {
					callback(false, {error:"json_decode_error", error_message:e.text}, method);
				}
			} else {
				callback(false, request.data, method);
			}
			
			delete openRequests[request];
		}
		
		/**
		 * 签名方法，返回签名字符串
		 * @param params 包含调用接口所有参数的一个Object
		 * 签名算法详见http://wiki.dev.renren.com/wiki/Calculate_signature
		 */
		public function sig(params:Object):String {
			var a:Array = [];
			for (var param:String in params) {
				if(params[param] is FileReference) {
					//AS3的FileReference貌似会自动加上两个参数，无奈签名的时候也加一下吧
					a.push("Filename=" + params[param].name);
					a.push("Upload=Submit Query");
				} else {
					a.push(param + "=" + params[param]);
				}
			}
			a.sort();
			var sig:String = a.join("");
			sig += nullToEmptyString(session.sessionSecret);
			//字符串转化成utf8试试
			sig = utf8Encode(sig);
			return MD5.hash(sig);
		}
		
		//把null变成空字符串""
		private function nullToEmptyString(s:String):String {
			if(s == null) {
				return "";
			}
			return s;
		}
		
		private function utf8Encode(string:String):String {
			string = string.replace(/\r\n/g,'\n');
			string = string.replace(/\r/g,'\n');
			
			var utfString:String = '';
			
			for (var i:int = 0 ; i < string.length ; i++) {
				var chr:Number = string.charCodeAt(i);
				if (chr < 128) {
					utfString += String.fromCharCode(chr);
				}
				else if ((chr > 127) && (chr < 2048)) {
					utfString += String.fromCharCode((chr >> 6) | 192);
					utfString += String.fromCharCode((chr & 63) | 128);
				}
				else {
					utfString += String.fromCharCode((chr >> 12) | 224);
					utfString += String.fromCharCode(((chr >> 6) & 63) | 128);
					utfString += String.fromCharCode((chr & 63) | 128);
				}
			}
			
			return utfString;
		}
	}
}