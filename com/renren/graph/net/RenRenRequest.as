package com.renren.graph.net {
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.DataEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class RenRenRequest {
		
		protected var _success:Boolean;
		
		protected var _rawData:String;
		
		protected var _data:Object;
		
		//todo callback参数列表，及错误信息的解释
		//为什么返回是一个Request？本身它就作为一个Key
		protected var callback:Function;
		
		protected var urlRequest:URLRequest;
		
		protected var urlLoader:URLLoader;
		
		protected var fileReference:FileReference;
		
		public function RenRenRequest():void {
			
		}
		
		public function get success():Boolean {
			return _success;
		}
		
		public function get rawData():String {
			return _rawData;
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function send(url:String,
							   params:* = null, 
							   callback:Function = null,
							   method:String = "POST"
							   ):void {
			this.callback = callback;
			urlRequest = new URLRequest();
			urlRequest.url = url;
			urlRequest.method = method;
			
			var uploadDataFieldName:String;
			var data:URLVariables = new URLVariables();
			for (var n:String in params) {
				data[n] = params[n];
				if(fileReference == null && data[n] is FileReference) {
					uploadDataFieldName = n;
					fileReference = data[n];
					delete data[n];
				}
			}
			urlRequest.data = data;
			
			if(fileReference != null) {
				urlRequest.method = URLRequestMethod.POST;
				fileReference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, handleFileReferenceData);
				fileReference.addEventListener(IOErrorEvent.IO_ERROR, handelFileReferenceError);
				fileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handelFileReferenceError);
				fileReference.upload(urlRequest, uploadDataFieldName);
			} else {
				loadURLLoader();
			}
		}
		
		//退出当前请求并释放资源
		public function close():void {
			if (urlLoader != null) {
				urlLoader.removeEventListener(Event.COMPLETE, handleURLLoaderComplete);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, handleURLLoaderIOError);
				urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleURLLoaderSecurityError);
				try {
					urlLoader.close();
				} catch (e:*) { }
				
				urlLoader = null;
			}
			
			if (fileReference != null) {
				fileReference.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, handleFileReferenceData);
				fileReference.removeEventListener(IOErrorEvent.IO_ERROR, handelFileReferenceError);
				fileReference.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handelFileReferenceError);
				
				try {
					fileReference.cancel();
				} catch (e:*) { }
				
				fileReference = null;
			}
		}
		
		//
		protected function loadURLLoader():void {
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, handleURLLoaderComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleURLLoaderIOError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleURLLoaderSecurityError);
			urlLoader.load(urlRequest);
		}
		
		//URLLoader加载完毕后执行此函数
		protected function handleURLLoaderComplete(event:Event):void {
			_success = true;
			_rawData = (event.target as URLLoader).data;
			_data = _rawData;
			
			dispatchComplete();
		}
		
		//处理URLLoader的I/O错误
		protected function handleURLLoaderIOError(event:IOErrorEvent):void {
			_success = false;
			_rawData = (event.target as URLLoader).data;
			_data = {error:"io_error", error_message:event.toString()};
			
			dispatchComplete();
		}
		
		//处理URLLoader的安全错误
		protected function handleURLLoaderSecurityError(event:SecurityErrorEvent):void {
			_success = false;
			_rawData = (event.target as URLLoader).data;
			_data = {error:"security_error", error_message:event.toString()};
			
			dispatchComplete();
		}
		
		protected function handleFileReferenceData(event:DataEvent):void {
			_success = true;
			_rawData = event.data;
			_data = _rawData;
			
			dispatchComplete();
		}
		
		protected function handelFileReferenceError(event:ErrorEvent):void {
			_success = false;
			_data = {error:"io_error", error_message:event.toString()};
			
			dispatchComplete();
		}
		
		protected function dispatchComplete():void {
			callback(this);
			close();
		}
		
		public function toString():String {
			return urlRequest.url +
				(urlRequest.data == null
					? ''
					: '?' + unescape(urlRequest.data.toString()));
		}
	}
}