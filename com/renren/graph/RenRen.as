/*
 * Author: 曹亮
 * Email: liang.cao@opi-corp.com
 */

package com.renren.graph {
	
	import com.renren.graph.core.RenRenAPI;
	import com.renren.graph.core.RenRenAuth;
	import com.renren.graph.core.RenRenWidget;
	import com.renren.graph.data.RenRenSession;
	import com.renren.graph.event.RenRenEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	[Event(name=RenRenEvent.AUTH_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.AUTH_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.API_NOT_READY, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.ADMIN_GET_ALLOCATION_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.ADMIN_GET_ALLOCATION_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FRIENDS_ARE_FRIENDS_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FRIENDS_ARE_FRIENDS_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FRIENDS_GET_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FRIENDS_GET_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FRIENDS_GET_FRIENDS_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FRIENDS_GET_FRIENDS_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FRIENDS_GET_APP_FRIENDS_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FRIENDS_GET_APP_FRIENDS_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.INVITATIONS_CREATE_LINK_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.INVITATIONS_CREATE_LINK_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.INVITATIONS_GET_INFO_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.INVITATIONS_GET_INFO_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.NOTIFICATIONS_SEND_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.NOTIFICATIONS_SEND_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.NOTIFICATIONS_SEND_EMAIL_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.NOTIFICATIONS_SEND_EMAIL_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PAGES_IS_FAN_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PAGES_IS_FAN_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PAY_IS_COMPLETED_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PAY_IS_COMPLETED_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PAY_REG_ORDER_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PAY_REG_ORDER_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PAY4TEST_IS_COMPLETED_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PAY4TEST_IS_COMPLETED_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PAY4TEST_REG_ORDER_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PAY4TEST_REG_ORDER_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.USERS_GET_INFO_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.USERS_GET_INFO_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.USERS_GET_LOGGED_IN_USER_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.USERS_GET_LOGGED_IN_USER_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.USERS_HAS_APP_PERMISSION_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.USERS_HAS_APP_PERMISSION_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.USERS_IS_APP_USER_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.USERS_IS_APP_USER_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.STATUS_GETS_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.STATUS_GETS_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.STATUS_SET_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.STATUS_SET_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.STATUS_GET_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.STATUS_GET_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.STATUS_GET_COMMENT_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.STATUS_GET_COMMENT_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_CREATE_ALBUM_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_CREATE_ALBUM_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_GET_ALBUMS_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_GET_ALBUMS_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_UPLOAD_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_UPLOAD_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_GET_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_GET_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_GET_COMMENTS_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_GET_COMMENTS_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_ADD_COMMENT_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.PHOTOS_ADD_COMMENT_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.BLOG_ADD_BLOG_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.BLOG_ADD_BLOG_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.BLOG_GETS_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.BLOG_GETS_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.BLOG_GET_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.BLOG_GET_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.BLOG_GET_COMMENTS_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.BLOG_GET_COMMENTS_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.BLOG_ADD_COMMENT_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.BLOG_ADD_COMMENT_FAIL, type="com.renren.graph.event.RenRenEvent")]
	
	/*[Event(name=RenRenEvent.WIDGET_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.WIDGET_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.WIDGET_FEED_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.WIDGET_FEED_FAIL, type="com.renren.graph.event.RenRenEvent")]*/
	[Event(name=RenRenEvent.FEED_DIALOG_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FEED_DIALOG_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.REQUEST_DIALOG_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.REQUEST_DIALOG_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.STATUS_DIALOG_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.STATUS_DIALOG_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.LIKE_DIALOG_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.LIKE_DIALOG_FAIL, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FRIENDS_DIALOG_SUCCESS, type="com.renren.graph.event.RenRenEvent")]
	[Event(name=RenRenEvent.FRIENDS_DIALOG_FAIL, type="com.renren.graph.event.RenRenEvent")]
	
	
	/**
	 * RenRen是人人网开放平台AS3 SDK的核心类
	 * 
	 * 其主要功能包括：<br/>
	 * <ul>
	 *   <li>封装了人人网开放平台的OAuth2.0授权</li>
	 *   <li>封装了人人网开放平台的REST API</li>
	 *	 <li>封装了人人网开放平台的Dialog，需要同时引入JS SDK</li>
	 *   <li>不仅可以提供回调获得API调用结果，还可以采用事件处理的机制</li>
	 *   <li>提供通用接口以满足线上接口更新后SDK未封装的情况</li>
	 * </ul>
	 * 一般情况下，当一个动作（验证授权或API调用）完成，会产生一个<b>RenRenEvent</b>事件，具体事件类型请参照函数说明文档。
	 * 调用者可以从RenRenEvent的data属性获得返回的数据，data属性是一个Object：
	 * <ul>
	 *   <li>如果调用成功，Object数据格式可以参考每个接口方法的成功返回样例</li>
	 *   <li>如果调用失败，Object数据格式如表格所示</li>
	 * </ul>
	 * <table>
	 *   <tr>
	 *     <td><b>error</b></td>
	 *     <td>错误的类型，包括auth_error,api_error,json_decode_error,io_error,security_error</td>
	 *   </tr>
	 *   <tr>
	 *     <td><b>error_message</b></td>
	 *     <td>错误的说明信息，帮助找到错误来源</td>
	 *   </tr>
	 *   <tr>
	 *     <td><b>error_code</b></td>
	 *     <td>在类型为auth_error,api_error时候有定义，与我们的文档一致</td>
	 *   </tr>
	 *   <tr>
	 *     <td><b>error_uri</b></td>
	 *     <td>在类型为auth_error时候有定义，与我们的文档一致</td>
	 *   </tr>
	 * </table>
	 */	
	
	public class RenRen extends EventDispatcher {
		
		//验证授权功能通过RenRenAuth来完成
		private var renrenAuth:RenRenAuth;
		
		//REST API调用通过RenRenAPI来完成
		private var renrenAPI:RenRenAPI;
		
		//Widget API通过RenRenWidget来完成
		private var renrenWidget:RenRenWidget;
		
		//为了让每个API接口的调用过程更加统一，创建一个字典保存每个API接口对应的数据处理函数和事件类型
		private var apiMethodMap:Dictionary = new Dictionary();
		
		//widget相关参数
		private var uiWidgetMap:Dictionary = new Dictionary();
		
		public function RenRen() {
			//初始化apiMethodMap，为每个接口添加数据处理函数和事件类型
			apiMethodMap["admin.getAllocation"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.ADMIN_GET_ALLOCATION_SUCCESS,
				failEvent:RenRenEvent.ADMIN_GET_ALLOCATION_FAIL};
			apiMethodMap["friends.areFriends"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.FRIENDS_ARE_FRIENDS_SUCCESS,
				failEvent:RenRenEvent.FRIENDS_ARE_FRIENDS_FAIL};
			apiMethodMap["friends.get"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.FRIENDS_GET_SUCCESS,
				failEvent:RenRenEvent.FRIENDS_GET_FAIL};
			apiMethodMap["friends.getFriends"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.FRIENDS_GET_FRIENDS_SUCCESS,
				failEvent:RenRenEvent.FRIENDS_GET_FRIENDS_FAIL};
			apiMethodMap["friends.getAppFriends"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.FRIENDS_GET_APP_FRIENDS_SUCCESS,
				failEvent:RenRenEvent.FRIENDS_GET_APP_FRIENDS_FAIL};
			apiMethodMap["invitations.createLink"] = {
				dataProcessor:getOriginObject,
				successEvent:RenRenEvent.INVITATIONS_CREATE_LINK_SUCCESS,
				failEvent:RenRenEvent.INVITATIONS_CREATE_LINK_FAIL};
			apiMethodMap["invitations.getInfo"] = {
				dataProcessor:getOriginObject,
				successEvent:RenRenEvent.INVITATIONS_GET_INFO_SUCCESS,
				failEvent:RenRenEvent.INVITATIONS_GET_INFO_FAIL};
			apiMethodMap["notifications.send"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.NOTIFICATIONS_SEND_SUCCESS,
				failEvent:RenRenEvent.NOTIFICATIONS_SEND_FAIL};
			apiMethodMap["notifications.sendEmail"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.NOTIFICATIONS_SEND_EMAIL_SUCCESS,
				failEvent:RenRenEvent.NOTIFICATIONS_SEND_EMAIL_FAIL};
			apiMethodMap["pages.isFan"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PAGES_IS_FAN_SUCCESS,
				failEvent:RenRenEvent.PAGES_IS_FAN_FAIL};
			apiMethodMap["pay.isCompleted"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PAY_IS_COMPLETED_SUCCESS,
				failEvent:RenRenEvent.PAY_IS_COMPLETED_FAIL};
			apiMethodMap["pay.regOrder"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PAY_REG_ORDER_SUCCESS,
				failEvent:RenRenEvent.PAY_REG_ORDER_FAIL};
			apiMethodMap["pay4Test.isCompleted"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PAY4TEST_IS_COMPLETED_SUCCESS,
				failEvent:RenRenEvent.PAY4TEST_IS_COMPLETED_FAIL};
			apiMethodMap["pay4Test.regOrder"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PAY4TEST_REG_ORDER_SUCCESS,
				failEvent:RenRenEvent.PAY4TEST_REG_ORDER_FAIL};
			apiMethodMap["users.getInfo"] = {
				dataProcessor:getFirstObjectFromArray, 
				successEvent:RenRenEvent.USERS_GET_INFO_SUCCESS,
				failEvent:RenRenEvent.USERS_GET_INFO_FAIL};
			apiMethodMap["users.getLoggedInUser"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.USERS_GET_LOGGED_IN_USER_SUCCESS,
				failEvent:RenRenEvent.USERS_GET_LOGGED_IN_USER_FAIL};
			apiMethodMap["users.hasAppPermission"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.USERS_HAS_APP_PERMISSION_SUCCESS,
				failEvent:RenRenEvent.USERS_HAS_APP_PERMISSION_FAIL};
			apiMethodMap["users.isAppUser"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.USERS_IS_APP_USER_SUCCESS,
				failEvent:RenRenEvent.USERS_IS_APP_USER_FAIL};
			apiMethodMap["status.gets"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.STATUS_GETS_SUCCESS,
				failEvent:RenRenEvent.STATUS_GETS_FAIL};
			apiMethodMap["status.set"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.STATUS_SET_SUCCESS,
				failEvent:RenRenEvent.STATUS_SET_FAIL};
			apiMethodMap["status.get"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.STATUS_GET_SUCCESS,
				failEvent:RenRenEvent.STATUS_GET_FAIL};
			apiMethodMap["status.getComment"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.STATUS_GET_COMMENT_SUCCESS,
				failEvent:RenRenEvent.STATUS_GET_COMMENT_FAIL};
			apiMethodMap["photos.createAlbum"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PHOTOS_CREATE_ALBUM_SUCCESS,
				failEvent:RenRenEvent.PHOTOS_CREATE_ALBUM_FAIL};
			apiMethodMap["photos.getAlbums"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PHOTOS_GET_ALBUMS_SUCCESS,
				failEvent:RenRenEvent.PHOTOS_GET_ALBUMS_FAIL};
			apiMethodMap["photos.upload"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PHOTOS_UPLOAD_SUCCESS,
				failEvent:RenRenEvent.PHOTOS_UPLOAD_FAIL};
			apiMethodMap["photos.get"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PHOTOS_GET_SUCCESS,
				failEvent:RenRenEvent.PHOTOS_GET_FAIL};
			apiMethodMap["photos.getComments"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PHOTOS_GET_COMMENTS_SUCCESS,
				failEvent:RenRenEvent.PHOTOS_GET_COMMENTS_FAIL};
			apiMethodMap["photos.addComment"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.PHOTOS_ADD_COMMENT_SUCCESS,
				failEvent:RenRenEvent.PHOTOS_ADD_COMMENT_FAIL};
			apiMethodMap["blog.addBlog"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.BLOG_ADD_BLOG_SUCCESS,
				failEvent:RenRenEvent.BLOG_ADD_BLOG_FAIL};
			apiMethodMap["blog.gets"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.BLOG_GETS_SUCCESS,
				failEvent:RenRenEvent.BLOG_GETS_FAIL};
			apiMethodMap["blog.get"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.BLOG_GET_SUCCESS,
				failEvent:RenRenEvent.BLOG_GET_FAIL};
			apiMethodMap["blog.getComments"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.BLOG_GET_COMMENTS_SUCCESS,
				failEvent:RenRenEvent.BLOG_GET_COMMENTS_FAIL};
			apiMethodMap["blog.addComment"] = {
				dataProcessor:getOriginObject, 
				successEvent:RenRenEvent.BLOG_ADD_COMMENT_SUCCESS,
				failEvent:RenRenEvent.BLOG_ADD_COMMENT_FAIL};
			
			uiWidgetMap["feed"] = {
				successEvent:RenRenEvent.FEED_DIALOG_SUCCESS,
				failEvent:RenRenEvent.FEED_DIALOG_FAIL};
			uiWidgetMap["request"] = {
				successEvent:RenRenEvent.REQUEST_DIALOG_SUCCESS,
				failEvent:RenRenEvent.REQUEST_DIALOG_FAIL};
			uiWidgetMap["status"] = {
				successEvent:RenRenEvent.STATUS_DIALOG_SUCCESS,
				failEvent:RenRenEvent.STATUS_DIALOG_FAIL};
			uiWidgetMap["like"] = {
				successEvent:RenRenEvent.LIKE_DIALOG_SUCCESS,
				failEvent:RenRenEvent.LIKE_DIALOG_FAIL};
			uiWidgetMap["friends"] = {
				successEvent:RenRenEvent.FRIENDS_ARE_FRIENDS_SUCCESS,
				failEvent:RenRenEvent.FRIENDS_ARE_FRIENDS_FAIL};
		}
		
		//数据处理函数之一，返回原始对象
		private function getOriginObject(result:Object):Object {
			return result;
		}
		
		//数据处理函数之一，返回数组的第一个元素
		private function getFirstObjectFromArray(result:Array):Object {
			return result[0];
		}
		
		/**
		 * 通过RenRenAuth进行初始化，验证流程是OAuth2.0的User-Agent Flow
		 * 
		 * <ul>
		 * <li>如果接口调用成功，会从服务器获得一个RenRenSession对象，并自动用这个RenRenSession对象来初始化
		 * RenRenAPI，抛出事件类型为RenRenEvent.AUTH_SUCCESS；</li>
		 * <li>如果接口调用失败，RenRenAPI没有被初始化，不能正常使用，抛出事件类型为RenRenEvent.AUTH_FAIL</li>
		 * </ul>
		 * 
		 * @param scope 可选参数 要求用户进行授权的权限列表，可以参考下面的链接
		 * 
		 * @see http://wiki.dev.renren.com/wiki/%E6%9D%83%E9%99%90%E5%88%97%E8%A1%A8
		 */
		public function auth(display:String = "popup", scope:String = ""):void {
			if(renrenAuth == null) {
				renrenAuth = new RenRenAuth(authCallback);
			}
			renrenAuth.auth(display, scope);
			//renrenAuth.tryToGetToken();
		}
		
		/**
		 * 自动授权的方法，第三方应用如果没有自己开发保存之前OAuth流程获得的access_token的话，
		 * 可以通过这个接口获得当前登录用户之前授权得到的access_token，避免了重新走OAuth流程，
		 * 每次都弹窗的问题。注意只有用户登录了人人网才能授权成功。
		 * 
		 * <ul>
		 * <li>如果接口调用成功，会从服务器获得一个RenRenSession对象，并自动用这个RenRenSession对象来初始化
		 * RenRenAPI，抛出事件类型为RenRenEvent.AUTH_SUCCESS；</li>
		 * <li>如果接口调用失败，RenRenAPI没有被初始化，不能正常使用，抛出事件类型为RenRenEvent.AUTH_FAIL</li>
		 * </ul>
		 */
		public function autoAuth():void {
			if(renrenAuth == null) {
				renrenAuth = new RenRenAuth(authCallback);
			}
			renrenAuth.tryToGetToken();
		}
		
		//提供给RenRenAuth的回调函数
		private function authCallback(success:Boolean,
									    data:Object):void {
			var event:RenRenEvent;
			if(success) {
				event = new RenRenEvent(RenRenEvent.AUTH_SUCCESS);
				renrenAPI = new RenRenAPI(data as RenRenSession);
				event.data = data;
			} else {
				event = new RenRenEvent(RenRenEvent.AUTH_FAIL);
				event.data = data;
			}
			dispatchEvent(event);
		}
		
		/**
		 * 如果不通过auth()方法走一个标准的OAuth验证流程的话，可以自己创建一个RenRenSession的实例，
		 * 并调用initAPI方法初始化RenRenAPI。这种情况适用于重新加载flash后授权丢失，第三方可以自己维护
		 * RenRenSession实例，不必重新要求用户授权
		 * 
		 * @param session 必选参数 一个合法的RenRenSession实例
		 */
		public function initAPI(session:RenRenSession):void {
			renrenAPI = new RenRenAPI(session);
		}
		
		/**
		 * 用这个方法可以直接调用API，用来提供通用接口以满足线上接口更新后SDK未封装的情况
		 * 
		 * @param method 必选参数 接口名称，与REST API的method参数对应。如：admin.getAllocation
		 * @param params 可选参数 调用接口用到的其他参数
		 * @param callback 可选参数 指定回调函数之后，调用完成后将不再发送事件，而是进入回调函数处理
		 */
		public function api(method:String,
							  params:Object = null,
							  callback:Function = null):void {
			if(renrenAPI == null) {
				var event:RenRenEvent = new RenRenEvent(RenRenEvent.API_NOT_READY);
				dispatchEvent(event);
			} else {
				if(callback != null) {
					renrenAPI.call(method, params, callback);
				} else {
					renrenAPI.call(method, params, apiCallback);
				}
			}
		}
		
		//一般的api调用这个就可以，把JSON串转化成对象
		private function apiCallback(success:Boolean, 
									   data:Object, 
									   method:String):void {
			var dataProcessor:Function = apiMethodMap[method].dataProcessor;
			var successEvent:String = apiMethodMap[method].successEvent;
			var failEvent:String = apiMethodMap[method].failEvent;
			var event:RenRenEvent;
			if(success) {
				event = new RenRenEvent(successEvent);
				event.data = dataProcessor(data);
			} else {
				event = new RenRenEvent(failEvent);
				event.data = data;
			}
			dispatchEvent(event);
		}
		
		/**
		 * 用这个方法可以直接调用Widget API，用来提供通用接口以满足线上接口更新后SDK未封装的情况
		 * 
		 * @param widget 必选参数 Widget的名称，包括feed，request,status,like,friends等等，具体请参照人人发布的widget
		 * @param options 必选参数 调用widget所需的参数
		 * @param callback 可选参数 指定回调函数之后，调用完成后将不再发送事件，而是进入回调函数处理
		 */
		public function ui(widget:String,
						     options:Object = null,
							 callback:Function = null):void {
			if(renrenWidget == null) {
				renrenWidget = new RenRenWidget();
			}

			if(callback != null) {
				renrenWidget.open(widget, options, callback);
			} else {
				renrenWidget.open(widget, options, uiCallback);
			}
		}
		
		private function uiCallback(success:Boolean, 
									  data:Object, 
									  widget:String):void {
			var successEvent:String = uiWidgetMap[widget].successEvent;
			var failEvent:String = uiWidgetMap[widget].failEvent;
			var event:RenRenEvent;
			if(success) {
				event = new RenRenEvent(successEvent);
				event.data = data;
			} else {
				event = new RenRenEvent(failEvent);
				event.data = data;
			}
			dispatchEvent(event);
		}
		
		//管理类接口
		
		/**
		 * 得到一个应用当天可以发送的通知和邀请的配额。
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * {"requests_per_day": 10, "notifications_per_day": 10}
		 * 其中：
		 * notifications_per_day表示一个用户当天可以发送通知的配额
		 * requests_per_day表示一个用户当天可以发送应用邀请的配额
		 * </listing>
		 */
		public function admin_getAllocation(callback:Function = null):void {
			var params:Object = new Object();
			api("admin.getAllocation", params, callback);
		}
		
		//好友关系类接口
		/**
		 * 判断两组用户是否互为好友关系，比较的两组用户数必须相等。
		 * <ul>
		 * <li>如果接口调用成功，抛出事件类型为RenRenEvent.FRIENDS_ARE_FRIENDS_SUCCESS；</li>
		 * <li>如果接口调用失败，抛出事件类型为RenRenEvent.FRIENDS_ARE_FRIENDS_FAIL。</li>
		 * </ul>
		 * 
		 * @param uids1 必选参数 第一组用户的ID，每个ID之间以逗号分隔
		 * @param uids2 必选参数 第二组用户的ID，每个ID之间以逗号分隔
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * [
		 *     {"uid1": 43054, "uid2": 222209506, "are_friends": 1}, 
		 *     {"uid1": 43054, "uid2": 12345, "are_friends": 0}
		 * ]
		 * 其中：
		 * uid1表示相对比的第一组中的用户id
		 * uid2表示相对比的第二组中的用户id
		 * are_friends表示是否为好友，1表示是，0表示否
		 * </listing>
		 */
		public function friends_areFriends(uids1:String, 
										     uids2:String, 
											 callback:Function = null):void {
			var params:Object = new Object();
			params.uids1 = uids1;
			params.uids2 = uids2;
			api("friends.areFriends", params, callback);
		}
		
		/**
		 * 得到当前登录用户的好友列表，得到的只是含有好友uid的列表。
		 * <ul>
		 * <li>如果接口调用成功，抛出事件类型为RenRenEvent.FRIENDS_GET_SUCCESS；</li>
		 * <li>如果接口调用失败，抛出事件类型为RenRenEvent.FRIENDS_GET_FAIL。</li>
		 * </ul>
		 * 
		 * @param page 可选参数 分页当前页码，默认为1
		 * @param count 可选参数 每页返回条目数，默认为500
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * [29532, 42301]
		 * </listing>
		 */
		public function friends_get(page:Number, 
									  count:Number, 
									  callback:Function = null):void {
			var params:Object = new Object();
			params.page = page.toString();
			params.count = count.toString();
			api("friends.get", params, callback);
		}
		
		/**
		 * 得到当前登录用户的好友列表。和friends.get相比好友的信息更加详细
		 * <ul>
		 * <li>如果接口调用成功，抛出事件类型为RenRenEvent.FRIENDS_GET_FRIENDS_SUCCESS；</li>
		 * <li>如果接口调用失败，抛出事件类型为RenRenEvent.FRIENDS_GET_FRIENDS_FAIL。</li>
		 * </ul>
		 * 
		 * @param page 可选参数 分页当前页码，默认为1
		 * @param count 可选参数 每页返回条目数，默认为500
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 *  [
		 *		{
		 *			"id": 29532,
		 *			"tinyurl": "http://hdn.xnimg.cn/photos/hdn111/20090806/1130/tiny_35v8_27321l204234.jpg",
		 *			"name": "孙志岗",
		 *			"headurl": "http://head.xiaonei.com/photos/20070518/1130/head169153.jpg"
		 *		},
		 *		{
		 *			"id": 42301,
		 *			"tinyurl": "http://hd23.xiaonei.com/photos/hd23/20080112/20/31/tiny_8313h169.jpg",
		 *			"name": "刘德超",
		 *			"headurl": "http://hd23.xiaonei.com/photos/hd23/20080112/20/31/head_8313h169.jpg"
		 *		}
		 *	]
		 * 其中：
		 * id表示好友的用户ID
		 * name表示好友的名字
		 * headurl表示好友的中等头像
		 * tinyurl表示好友的小头像
		 * </listing>
		 */
		public function friends_getFriends(page:Number, 
										     count:Number, 
											 callback:Function = null):void {
			var params:Object = new Object();
			params.page = page.toString();
			params.count = count.toString();
			api("friends.getFriends", params, callback);
		}
		
		/**
		 * 返回App好友的ID列表。App好友是指某个用户安装了同一应用的好友。
		 * <ul>
		 * <li>如果接口调用成功，抛出事件类型为RenRenEvent.FRIENDS_GET_APP_FRIENDS_SUCCESS；</li>
		 * <li>如果接口调用失败，抛出事件类型为RenRenEvent.FRIENDS_GET_APP_FRIENDS_FAIL。</li>
		 * </ul>
		 * 
		 * @param fields 可选参数 返回的字段列表，可以指定返回那些字段，用逗号分隔。
		 * 目前支持name（姓名）、tinyurl(小头像)、headurl（中等头像），如果不传递此参数，默认返回好友id节点
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 *  [
		 *		{"name": "张铁蕾", "uid": 240650143},
		 *		{"name": "朱允铭", "uid": 121943204},
		 *		{"name": "崔浩波", "uid": 66271},
		 *		{"name": "刘玉珊", "uid": 200006729},
		 *	]
		 * 其中：
		 * name表示用户名字
		 * tinyurl表示用户小头像
		 * headurl表示用户中头像
		 * </listing>
		 */
		public function friends_getAppFriends(fields:String, 
											    callback:Function = null):void {
			var params:Object = new Object();
			params.fields = fields;
			api("friends.getAppFriends", params, callback);
		}
		
		//邀请类接口
		/**
		 * 生成站外邀请用户注册的链接地址,应用可以引导用户通过QQ或者msn等渠道邀请好友加入应用。
		 * 
		 * @param domain 可选参数 获取邀请链接地址的域名属性，0表示人人(wwv.renren.com)，1表示开心(wwv.kaixin.com)，默认值为人人
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * ["http://wwv.renren.com/xn2.do?iid=3da72034-4e4f-2c0c-8d95-7a29ba6a55b6"]
		 * </listing>
		 */
		public function invitations_createLink(domain:Number, 
											   callback:Function = null):void {
			var params:Object = new Object();
			params.domain = domain.toString();
			api("invitations.createLink", params, callback);
		}
		
		/**
		 * 根据应用新用户的id获取用户的是否通过邀请安装，同时得到此次邀请的详细信息（包括邀请者、邀请时间、被邀请者等）。
		 * 接口可以按照用户id或者时间段来查询
		 * 
		 * @param invitee_id 可选参数 被邀请者的用户id
		 * @param begin_time 可选参数 查询起始时间，格式为：yyyy-MM-dd HH:mm:ss
		 * @param end_time 可选参数 查询结束时间，格式为：yyyy-MM-dd HH:mm:ss
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * [ 
		 *     { "invite_type":0,"inviter_uid":123, "invite_time":"2008-02-18 17:16","invitee_uid":10012}, 
		 *     { "invite_type":0,"inviter_uid":123, "invite_time":"2008-02-18 17:16","invitee_uid":10012} 
		 * ] 
		 * 其中：
		 * invitation_info表示邀请信息
		 * invite_type表示子节点表示邀请关系类型，0表示通过站外邀请使用应用，1表示通过站内邀请使用应用
		 * inviter_uid表示子节点表示邀请者用户Id
		 * invite_time表示子节点表示邀请者邀请时间，格式是 2008-02-18 17:16 时间格式为东八区+8时间格式
		 * invitee_uid表示子节点表示被邀请者注册人人网后的用户Id
		 * </listing>
		 */
		public function invitations_getInfo(invitee_id:Number = 0, 
											  begin_time:String = null, 
											  end_time:String = null, 
											  callback:Function = null):void {
			var params:Object = new Object();
			params.invitee_id = invitee_id.toString();
			params.begin_time = begin_time;
			params.end_time = end_time;
			api("invitations.getInfo", params, callback);
		}
		
		//通知类接口
		/**
		 * 给指定的用户发送通知。
		 * 
		 * @param to_ids 必选参数 用户id的列表，单个或多个，可以是逗号分隔，如 8055,8066,8077 。 
		 * @param notification 必选参数 通知的内容，可以是XNML类型的文本信息。
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "result":1 } 
		 * </listing>
		 */
		public function notifications_send(to_ids:String, 
										     notification:String, 
											 callback:Function = null):void {
			var params:Object = new Object();
			params.to_ids = to_ids;
			params.notification = notification;
			api("notifications.send", params, callback);
		}
		
		/**
		 * 在取得用户的授权后，给用户发送Email。 
		 * 
		 * @param template_id 必选参数 邮件模板的ID 
		 * @param recipients 必选参数 收件人的UID，多个ID用逗号隔开
		 * @param template_data 必选参数 JSON对象，渲染邮件模板所需要的数据。例如：{"who":"234234","static_uid":"23423423"}
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "uids":"2342342,234234,453234" }
		 * </listing>
		 */
		public function notifications_sendEmail(template_id:Number, 
												  recipients:String, 
												  template_data:String, 
												  callback:Function = null):void {
			var params:Object = new Object();
			params.template_id = template_id.toString();
			params.recipients = recipients;
			params.template_data = template_data;
			api("notifications.sendEmail", params, callback);
		}
		
		//公共主页类接口
		/**
		 * 判断用户是否为Page（公共主页）的粉丝。
		 * 
		 * @param page_id 可选参数 Page的ID，缺省时，值为当前应用对应的Page的ID
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "result":1 } 
		 * </listing>
		 */
		public function pages_isFan(page_id:Number, 
									  callback:Function = null):void {
			var params:Object = new Object();
			params.page_id = page_id.toString();
			api("pages.isFan", params, callback);
		}
		
		//获取公共主页的类型
		public function pages_getCategories(callback:Function = null):void {
			var params:Object = new Object();
			api("pages.getCategories", params, callback);
		}
		
		//获取某个page的信息
		public function pages_getInfo(page_id:Number,
									    fields:String,
									    callback:Function = null):void {
			var params:Object = new Object();
			params.page_id = page_id.toString();
			params.fields = fields;
			api("pages.getInfo", params, callback);
		}
		
		//以Session Key对应的用户是不是某个page的管理员
		public function pages_isAdmin(page_id:Number, 
									 callback:Function = null):void {
			var params:Object = new Object();
			params.page_id = page_id.toString();
			api("pages.isAdmin", params, callback);
		}
		
		//判断一个id是不是page
		public function pages_isPage(page_id:Number, 
									   callback:Function = null):void {
			var params:Object = new Object();
			params.page_id = page_id.toString();
			api("pages.isPage", params, callback);
		}
		
		//获取用户所关注的page列表
		public function pages_getList(page:Number, 
										count:Number, 
										category:Number,
										callback:Function = null):void {
			var params:Object = new Object();
			params.page = page.toString();
			params.count = count.toString();
			params.category = category.toString();
			api("pages.getList", params, callback);
		}
		
		//获取page的粉丝列表
		public function pages_getFansList(page_id:Number,
											page:Number, 
											count:Number, 
											callback:Function = null):void {
			var params:Object = new Object();
			params.page_id = page_id.toString();
			params.page = page.toString();
			params.count = count.toString();
			api("pages.getFansList", params, callback);
		}
		
		
		
		//支付类接口
		/**
		 * 查询某个用户在一个应用中一次消费是否完成（2008-10-27）。此接口在新的0.7版本以后提供使用中
		 * 
		 * @param order_id 必选参数 用户消费校内豆订单号。
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "result":1 } 
		 * </listing>
		 */
		public function pay_isCompleted(order_id:Number, 
										  callback:Function = null):void {
			var params:Object = new Object();
			params.order_id = order_id.toString();
			api("pay.isCompleted", params, callback);
		}
		
		/**
		 * 预存入用户在应用中消费产生的订单数据，消费金额等信息，
		 * 返回保证一个用户某次在一个应用中支付人人豆安全性的Token（2008-10-27）。
		 * 
		 * @param order_id 必选参数 用户消费校内豆订单号，参数必须保证唯一，每一次不能传递相同的参数。
		 * @param amount 必选参数 校内豆消费数额, 取值范围为[0,100]
		 * @param desc 必选参数 用户使用校内豆购买的虚拟物品的名称
		 * @param type 可选参数 0代表WEB支付订单，1代表WAP支付订单，默认值为0
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "token":"WVgOqa" } 
		 * 其中：
		 * token保证一个用户某次在一个应用中支付校内豆安全性的Token，应用在引导用户进入校内网校内豆支付平台时需传递此参数
         * 建议应用保存此Token在自己的库中，每个订单号对应唯一的Token，没有过期时间
		 * </listing>
		 */
		public function pay_regOrder(order_id:Number, 
									   amount:Number, 
									   desc:String, 
									   type:Number = 0, 
									   callback:Function = null):void {
			var params:Object = new Object();
			params.order_id = order_id.toString();
			params.amount = amount.toString();
			params.desc = desc;
			params.type = type;
			api("pay.regOrder", params, callback);
		}
		
		/**
		 * 只用于开发者模拟人人豆支付的测试，功能与pay.isCompleted一样（2008-12-18）。此接口在新的0.7版本以后提供使用中。
		 * 
		 * @param order_id 必选参数 用户消费校内豆订单号。
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "result":1 } 
		 * </listing>
		 */
		public function pay4Test_isCompleted(order_id:Number, 
											   callback:Function = null):void {
			var params:Object = new Object();
			params.order_id = order_id.toString();
			api("pay4Test.isCompleted", params, callback);
		}
		
		/**
		 * 只用于开发者模拟人人豆支付的测试，功能与pay.regOrder一样（2008-12-18）。
		 * 此接口在新的0.7版本以后提供使用中。 
		 * 
		 * @param order_id 必选参数 用户消费校内豆订单号，参数必须保证唯一，每一次不能传递相同的参数。
		 * @param amount 必选参数 校内豆消费数额, 取值范围为[0,100]
		 * @param desc 必选参数 用户使用校内豆购买的虚拟物品的名称
		 * @param type 可选参数 0代表WEB支付订单，1代表WAP支付订单，默认值为0
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "token":"WVgOqa" } 
		 * 其中：
		 * token保证一个用户某次在一个应用中支付校内豆安全性的Token，应用在引导用户进入校内网校内豆支付平台时需传递此参数
         * 建议应用保存此Token在自己的库中，每个订单号对应唯一的Token，没有过期时间
		 * </listing>
		 */
		public function pay4Test_regOrder(order_id:Number, 
										    amount:Number, 
											desc:String, 
											type:Number = 0, 
											callback:Function = null):void {
			var params:Object = new Object();
			params.order_id = order_id.toString();
			params.amount = amount.toString();
			params.desc = desc;
			params.type = type;
			api("pay4Test.regOrder", params, callback);
		}
		
		//用户信息类接口
		/**
		 * 得到用户信息,此接口在新的0.5版本以后中增加返回是否为星级和紫豆用户节点。 
		 * 
		 * @param uids 必选参数 需要查询的用户的id。
		 * @param fields 可选参数 返回的字段列表，可以指定返回那些字段，用逗号分隔。
		 * 如：uid,name,sex,star,zidou,vip,birthday,email_hash,tinyurl,headurl,
		 * mainurl,hometown_location,work_info,university_info。
		 * 如果不传递此参数默认返回uid,name,tinyurl,headhurl,zidou,star
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * {
		 *		"uid": 222209506,
		 *		"star": 1,
		 *		"zidou": 0,
		 *		"vip": 1,
		 *		"headurl": "http://hdn.xnimg.cn/photos/hdn221/20110218/0055/head_Ketf_179958n019118.jpg",
		 *		"sex": 1,
		 *		"name": "戴询",
		 *		"tinyurl": "http://hdn.xnimg.cn/photos/hdn221/20110218/0055/tiny_cgsz_179596k019118.jpg"
		 *	}
		 * 其中：
		 * uid 表示用户id
		 * name 表示用户名
		 * sex 表示性别，值1表示男性；值0表示女性
		 * star 表示是否为星级用户，校内中值1表示是；值0表示不是,开心中0表示非真实姓名和头像，1表示非真实姓名，2表示非真实头像，3表示真实用户
		 * zidou 表示是否为vip用户，值1表示是；值0表示不是
		 * vip 表示是否为vip用户等级，前提是zidou节点必须为1
		 * birthday 表示出生时间，格式为：yyyy-mm-dd，需要自行格式化日期显示格式。注：年份60后，实际返回1760-mm-dd；70后，返回1770-mm-dd；80后，返回1780-mm-dd；90后，返回1790-mm-dd
		 * email_hash 用户经过验证的email的信息字符串：email通过了connect.registerUsers接口。字符串包含的email经过了crc32和md5的编码
		 * tinyurl 表示头像链接 50*50大小
		 * headurl 表示头像链接 100*100大小
		 * mainurl 表示头像链接 200*200大小
		 * hometown_location 表示家乡信息
		 * country(子节点) 表示所在国家
		 * province（子节点）表示所在省份
		 * city（子节点）表示所在城市
		 * work_info> 表示工作信息
		 * company_name（子节点）表示所在公司
		 * description（子节点）表示工作描述
		 * start_date (子节点) 表示入职时间
		 * end_date（子节点）离职时间
		 * university_info 表示就读大学信息
		 * name（子节点）表示大学名
		 * year（子节点 表示入学时间
		 * department（子节点）表示学院
		 * hs_info 表示就读高中学校信息
		 * name（子节点）表示高中学校名
		 * grad_year（子节点）表示入学时间
		 * </listing>
		 */
		public function users_getInfo(uids:Number, 
									    fields:String = null, 
										callback:Function = null):void {
			var params:Object = new Object();
			params.uids = uids.toString();
			if(fields != null && fields != "") {
				params.fields = fields;
			}
			api("users.getInfo", params, callback);
		}
		
		/**
		 * 得到当前session的用户ID。 
		 * 
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "uid":222332 }
		 * </listing>
		 */
		public function users_getLoggedInUser(callback:Function = null):void {
			var params:Object = new Object();
			api("users.getLoggedInUser", params, callback);
		}
		
		/**
		 * 根据用户的id，以及相应在人人网的操作权限(接收email,更新状态等),来判断用户是否可以进行此操作,此接口在新的0.8版本以后提供使用。
		 * 
		 * @param ext_perm 必选参数 用户可操作的扩展授权，例如email
		 * @param uid 可选参数 用户ID
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "result":1 } 
		 * </listing>
		 */
		public function users_hasAppPermission(ext_perm:String, 
											     uid:String = null, 
												 callback:Function = null):void {
			var params:Object = new Object();
			params.ext_perm = ext_perm;
			params.uid = uid;
			api("users.hasAppPermission", params, callback);
		}
		
		/**
		 * 判断用户是否已对App授权。 
		 * 
		 * @param uid 可选参数 用户ID
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "result":1 } 
		 * </listing>
		 */
		public function users_isAppUser(uid:Number = 0, 
										  callback:Function = null):void {
			var params:Object = new Object();
			params.uid = uid.toString();
			api("users.isAppUser", params, callback);
		}
		
		//
		public function status_getEmoticons(type:String, 
											  callback:Function = null):void {
			var params:Object = new Object();
			params.type = type;
			api("status.getEmoticons", params, callback);
		}
		
		/**
		 * 返回指定用户的状态列表，不包含回复内容。如果不指定用户，则获取当前用户的状态信息。
		 * 
		 * @param uid 可选参数 状态信息所属用户id，不指定则根据sessionKey判断为当前用户
		 * @param page 可选参数 支持分页，指定页号，页号从1开始。缺省返回第一页数据。
		 * @param count 可选参数 支持分页，指定每页记录数，缺省为每页30条记录。
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "result":1 } 
		 * </listing>
		 */
		public function status_gets(uid:Number, 
									  page:Number, 
									  count:Number, 
									  callback:Function = null):void {
			var params:Object = new Object();
			params.uid = uid.toString();
			params.page = page.toString();
			params.count = count.toString();
			api("status.gets", params, callback);
		}
		
		/**
		 * 用户更新状态，支持转发的操作。
		 * 
		 * @param status 必选参数 用户更新的状态信息，最多140个字符
		 * @param forward_id 可选参数 被转发的状态id
		 * @param forward_owner 可选参数 被转发的状态所有者的id
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function status_set(status:String, 
								     forward_id:Number,
									 forward_owner:Number, 
									 callback:Function = null):void {
			var params:Object = new Object();
			params.status = status;
			params.forward_id = forward_id.toString();
			params.forward_owner = forward_owner.toString();
			api("status.set", params, callback);
		}
		
		/**
		 * 返回用户某条状态，包含回复内容，可以指定回复的条数,如果未指定状态id则返回当前用户最新的状态。 
		 * 
		 * @param status_id 必选参数 状态的id
		 * @param owner_id 可选参数 状态信息所属用户id，不指定则根据sessionKey判断为当前用户
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function status_get(status_id:Number,
								     owner_id:Number, 
									 callback:Function = null):void {
			var params:Object = new Object();
			params.status_id = status_id.toString();
			params.owner_id = owner_id.toString();
			api("status.get", params, callback);
		}
		
		/**
		 * 获取一条状态中的所有最新回复内容。 
		 * 
		 * @param status_id 必选参数 状态的id
		 * @param owner_id 必选参数 状态信息所属用户id
		 * @param page 可选参数 支持分页，指定页号，页号从1开始。缺省返回第一页数据。
		 * @param count 可选参数 支持分页，指定每页记录数，缺省为每页10条记录。
		 * @param order 可选参数 获取留言的排序规则，0表示升序(最旧到新)，1表示降序(最新到旧)，默认为0
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function status_getComment(status_id:Number, 
										    owner_id:Number, 
											page:Number, 
											count:Number, 
											order:Number, 
											callback:Function = null):void {
			var params:Object = new Object();
			params.status_id = status_id.toString();
			params.owner_id = owner_id.toString();
			params.page = page.toString();
			params.count = count.toString();
			params.order = order.toString();
			api("status.getComment", params, callback);
		}
		
		
		/**
		 * 获取用户的相册列表信息。当取第一页时，会返回头像相册和快速上传相册。 
		 * 
		 * @param name 必选参数 相册的名字
		 * @param location 可选参数 相册的地点
		 * @param description 可选参数 相册的描述
		 * @param visible 可选参数 相册的隐私设置. owner（自己）、friends（好友）、 networks（网络）、everyone(所有人)。
		 * 99(所有人),1(好友), 3(同网络人), -1(仅自己可见) 
		 * @param password 可选参数 相册的密码，支持字母，数字，符号，限16个字符
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function photos_createAlbum(name:String, 
										     location:String, 
											 description:String, 
											 visible:String, 
											 password:String, 
											 callback:Function = null):void {
			var params:Object = new Object();
			params.name = name;
			params.location = location;
			params.description = description;
			params.visible = visible;
			params.password = password;
			api("photos.createAlbum", params, callback);
		}
		
		/**
		 * 获取用户的相册列表信息。当取第一页时，会返回头像相册和快速上传相册。
		 * 
		 * @param uid 必选参数 相册所有者的用户ID
		 * @param page 可选参数 分页的页数，默认值为1
		 * @param count 可选参数 分页后每页的个数，默认值为10
		 * @param aids 可选参数 多个相册的ID，以逗号分隔，最多支持10个数据
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function photos_getAlbums(uid:Number, 
										   page:Number, 
										   count:Number, 
										   aids:String, 
										   callback:Function = null):void {
			var params:Object = new Object();
			params.uid = uid.toString();
			params.page = page.toString();
			params.count = count.toString();
			params.aids = aids;
			api("photos.getAlbums", params, callback);
		}
		
		/**
		 * 上传照片到用户的相册，同时返回这张照片的信息。
		 * 
		 * @param upload 必选参数 文件的数据,类型为AS3的FileRefercnce，上传前请使用它的browser方法选择文件
		 * @param caption 可选参数 照片的描述信息
		 * @param aid 可选参数 相册的ID，如果指定此参数，将会传到指定相册，默认传到手机相册
		 * @param source_link 可选参数 新鲜事中来源信息链接。该参数为JSON格式，格式如下：{ "text": "App A", "href": "http://appa.com/path" } 
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function photos_upload(upload:FileReference, 
									    caption:String, 
										aid:Number, 
										source_link:String, 
										callback:Function = null):void {
			var params:Object = new Object();
			params.upload = upload;
			params.caption = caption;
			params.aid = aid;
			params.source_link = source_link;
			api("photos.upload", params, callback);
		}
		
		/**
		 * 获取可见照片的相关信息，可以根据以下参数的组合获取结果： 
		 * 相册ID和用户ID,获取相册中所有照片的信息
		 * 照片ID和用户ID，获取指定照片的信息
		 * 照片ID、相册ID和用户ID，获取所有指定数据 
		 * 
		 * @param uid 必选参数 照片所有者的用户ID或公共主页的ID
		 * @param aid 可选参数 相册的id。aid和pids至少传递一个
		 * @param password 可选参数 加密相册的密码。如果相册为加密相册，传递此参数
		 * @param page 可选参数 页码，默认值为1，必须大于0，无上限
		 * @param count 可选参数 每页的容量，默认值为10，必须大于0，无上限
		 * @param pids 可选参数 照片id串，以分","割，最多20个。aid和pids至少传递一个，传递pids则无需传递page和count参数
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function photos_get(uid:String, 
								     aid:String, 
									 password:String, 
									 page:String, 
									 count:String, 
									 pids:String, 
								     callback:Function = null):void {
			var params:Object = new Object();
			params.uid = uid;
			params.aid = aid;
			params.password = password;
			params.page = page;
			params.count = count;
			params.pids = pids;
			api("photos.get", params, callback);
		}
		
		/**
		 * photos.addComment
		 * 对可见照片或者相册进行评论，可使用下面的不同参数进行不同的操作 
		 * 使用相册ID对相册的发起评论
		 * 使用照片ID对照片的发起评论
		 * 使用相册ID或者照片ID与被回复用户ID的组合表示对评论发起二级回复
		 * 
		 * @param uid 必选参数 照片或相册所有者的用户ID
		 * @param content 必选参数 评论的内容，最多140字
		 * @param aid 可选参数 相册的id。aid和pid至少传递一个
		 * @param pid 可选参数 照片id。aid和pid至少传递一个
		 * @param rid 可选参数 评论的用户id，如果想对评论中的评论进行二级回复需要传递此参数
		 * @param type 可选参数 评论的类型，是否为悄悄话，1表示悄悄话，0表示非悄悄话，默认为0
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function photos_addComment(uid:String, 
											content:String, 
											aid:String, 
											pid:String, 
											rid:String, 
											type:String, 
											callback:Function = null):void {
			var params:Object = new Object();
			params.uid = uid;
			params.content = content;
			params.aid = aid;
			params.pid = pid;
			params.rid = rid;
			params.type = type;
			api("photos.addComment", params, callback);
		}
		
		/**
		 * photos.getComments
		 * 对可见照片或者相册进行评论，可使用下面的不同参数进行不同的操作
		 * 使用相册ID获取相册的评论
		 * 使用照片ID获取照片的评论 
		 * 
		 * @param uid 必选参数 照片或相册所有者的用户ID
		 * @param aid 可选参数 相册的id。aid和pid至少传递一个
		 * @param pid 可选参数 照片id。aid和pid至少传递一个
		 * @param page 可选参数 支持分页，缺省值为1（第一页）
		 * @param count 可选参数 每页的数量，缺省值为10
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function photos_getComments(uid:String, 
											 aid:String, 
											 pid:String, 
											 page:String, 
											 count:String, 
											 callback:Function = null):void {
			var params:Object = new Object();
			params.uid = uid;
			params.aid = aid;
			params.pid = pid;
			params.page = page;
			params.count = count;
			api("photos.getComments", params, callback);
		}
		
		/**
		 * blog.addBlog
		 * 创建一篇日志。
		 * 
		 * @param title 必选参数 日志的标题
		 * @param content 必选参数 日志的内容
		 * @param visable 可选参数 日志的隐私设置，可用值有99(所有人可见)1(仅好友可见)4(需要密码)-1(仅自己可见),错传或没传,默认为99
		 * @param password 可选参数 用户设置的密码
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function blog_addBlog(title:String, 
									   content:String, 
									   visable:String, 
									   password:String, 
									   callback:Function = null):void {
			var params:Object = new Object();
			params.title = title;
			params.content = content;
			params.visable = visable;
			params.password = password;
			api("blog.addBlog", params, callback);
		}
		
		/**
		 * blog.gets
		 * 获取指定用户的可见日志信息列表。 
		 * 
		 * @param uid 必选参数 用户的ID或公共主页的ID
		 * @param page 可选参数 分页的页数，默认值为1
		 * @param count 可选参数 每页显示的日志的数量, 缺省值为20
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function blog_gets(uid:String, 
									page:String, 
									count:String, 
									callback:Function = null):void {
			var params:Object = new Object();
			params.uid = uid;
			params.page = page;
			params.count = count;
			api("blog.gets", params, callback);
		}
		
		/**
		 * blog.get
		 * 获取自己或好友一篇日志的信息。 
		 * 
		 * @param uid 必选参数 日志所有者的ID或公共主页的ID
		 * @param comment 可选参数 返回评论内容，最大值为50，默认值0
		 * @param password 可选参数 日志的密码（当日志有密码时）
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 */
		public function blog_get(uid:String, 
								   comment:String, 
								   password:String, 
								   callback:Function = null):void {
			var params:Object = new Object();
			params.uid = uid;
			params.comment = comment;
			params.password = password;
			api("blog.get", params, callback);
		}
		
		/**
		 * blog.getComments
		 * 获取一篇日志的评论。 
		 * 
		 * @param id 必选参数 日志id
		 * @param uid 必选参数 用户的ID或公共主页的ID
		 * @param page 可选参数 分页的页数，默认值为1
		 * @param count 默认值为20, 最大值为50, 每页所包含的评论数
		 * @param order 排序方式。1：代表逆序；0：正序。默认值为0
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * [ 
		 *     { 
		 *        "id":123, "uid":123,
		 *        "name":"姓名", 
		 *        "headurl":"", 
		 *        "time":"", 
		 *        "content":"", 
		 *        "is_whisper":1 
		 *     }
		 * ]
		 * </listing>
		 * 
		 */
		public function blog_getComments(id:String, 
										   uid:String, 
										   page:String, 
										   count:String, 
										   order:String, 
								 		   callback:Function = null):void {
			var params:Object = new Object();
			params.id = id;
			params.uid = uid;
			params.page = page;
			params.count = count;
			params.order = order;
			api("blog.getComments", params, callback);
		}
		
		/**
		 * 发布一个人人网日志的评论。 
		 * 
		 * @param id 必选参数 日志ID
		 * @param content 必选参数 评论的内容
		 * @param uid 必选参数 用户的ID或公共主页的ID
		 * @param rid 可选参数 用于二级回复，被回复的人的用户ID
		 * @param type 可选参数 是否为悄悄话，1表示悄悄话，0表示公开评论
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 * 
		 * @example 成功返回样例：
		 * <listing version="3.0">
		 * { "result":1 } 
		 * </listing>
		 */
		public function blog_addComment(id:String, 
										  content:String, 
										  uid:String, 
										  rid:String, 
										  type:String, 
										  callback:Function = null):void {
			var params:Object = new Object();
			params.id = id;
			params.content = content;
			params.uid = uid;
			params.rid = rid;
			params.type = type;
			api("blog.addComment", params, callback);
		}
		
		/**
		 * 发布新鲜事的feed_dialog
		 * 
		 * @param display 必选参数 dialog展示的方式：popup、iframe等等
		 * @param style 必选参数 dialog所需的样式参数
		 * @param params 必选参数 dialog所需的其他参数
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 */
		public function feed_dialog(display:String,
									  style:Object,
									  params:Object,
									  callback:Function = null):void {
			var options:Object = new Object();
			options.display = display;
			options.style = style;
			options.params = params;
			ui("feed", options, callback);	
		}
		
		/**
		 * 发布新鲜事的request_dialog
		 * 
		 * @param display 必选参数 dialog展示的方式：popup、iframe等等
		 * @param style 必选参数 dialog所需的样式参数
		 * @param params 必选参数 dialog所需的其他参数
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 */
		public function request_dialog(display:String,
										 style:Object,
										 params:Object,
										 callback:Function = null):void {
			var options:Object = new Object();
			options.display = display;
			options.style = style;
			options.params = params;
			ui("request", options, callback);
		}
		
		/**
		 * 发布新鲜事的status_dialog
		 * 
		 * @param display 必选参数 dialog展示的方式：popup、iframe等等
		 * @param style 必选参数 dialog所需的样式参数
		 * @param params 必选参数 dialog所需的其他参数
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 */
		public function status_dialog(display:String,
									   style:Object,
									   params:Object,
									   callback:Function = null):void {
			var options:Object = new Object();
			options.display = display;
			options.style = style;
			options.params = params;
			ui("status", options, callback);
		}
		
		/**
		 * 发布新鲜事的like_dialog
		 * 
		 * @param display 必选参数 dialog展示的方式：popup、iframe等等
		 * @param style 必选参数 dialog所需的样式参数
		 * @param params 必选参数 dialog所需的其他参数
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 */
		public function like_dialog(display:String,
									  style:Object,
									  params:Object,
									  callback:Function = null):void {
			var options:Object = new Object();
			options.display = display;
			options.style = style;
			options.params = params;
			ui("like", options, callback);
		}
		
		/**
		 * 发布新鲜事的friends_dialog
		 * 
		 * @param display 必选参数 dialog展示的方式：popup、iframe等等
		 * @param style 必选参数 dialog所需的样式参数
		 * @param params 必选参数 dialog所需的其他参数
		 * @param callback 可选参数 可以指定一个回调函数，这种情况下不会触发事件
		 */
		public function friends_dialog(display:String,
									  style:Object,
									  params:Object,
									  callback:Function = null):void {
			var options:Object = new Object();
			options.display = display;
			options.style = style;
			options.params = params;
			ui("friends", options, callback);
		}
	}
}