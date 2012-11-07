package com.renren.graph.event {
	
	import flash.events.Event;
	
	public class RenRenEvent extends Event {
		
		public static const GET_ACCESS_TOKEN_SUCCESS:String = "GET_ACCESS_TOKEN_SUCCESS";
		public static const GET_ACCESS_TOKEN_FAIL:String = "GET_ACCESS_TOKEN_FAIL";
		
		public static const GET_SESSION_KEY_SUCCESS:String = "GET_SESSION_KEY_SUCCESS";
		public static const GET_SESSION_KEY_FAIL:String = "GET_SESSION_KEY_FAIL";
		
		public static const AUTH_SUCCESS:String = "AUTH_SUCCESS";
		public static const AUTH_FAIL:String = "AUTH_FAIL";
		
		public static const CALL_API_SUCCESS:String = "CALL_API_SUCCESS";
		public static const CALL_API_FAIL:String = "CALL_API_FAIL";
		
		public static const API_READY:String = "API_READY";
		public static const API_NOT_READY:String = "API_NOT_READY";
		
		public static const ADMIN_GET_ALLOCATION_SUCCESS:String = "ADMIN_GET_ALLOCATION_SUCCESS";
		public static const ADMIN_GET_ALLOCATION_FAIL:String = "ADMIN_GET_ALLOCATION_FAIL";
		
		public static const FRIENDS_ARE_FRIENDS_SUCCESS:String = "FRIENDS_ARE_FRIENDS_SUCCESS";
		public static const FRIENDS_ARE_FRIENDS_FAIL:String = "FRIENDS_ARE_FRIENDS_FAIL";
		
		public static const FRIENDS_GET_SUCCESS:String = "FRIENDS_GET_SUCCESS";
		public static const FRIENDS_GET_FAIL:String = "FRIENDS_GET_FAIL";
		
		public static const FRIENDS_GET_FRIENDS_SUCCESS:String = "FRIENDS_GET_FRIENDS_SUCCESS";
		public static const FRIENDS_GET_FRIENDS_FAIL:String = "FRIENDS_GET_FRIENDS_FAIL";
		
		public static const FRIENDS_GET_APP_FRIENDS_SUCCESS:String = "FRIENDS_GET_APP_FRIENDS_SUCCESS";
		public static const FRIENDS_GET_APP_FRIENDS_FAIL:String = "FRIENDS_GET_APP_FRIENDS_FAIL";
		
		public static const INVITATIONS_CREATE_LINK_SUCCESS:String = "INVITATIONS_CREATE_LINK_SUCCESS";
		public static const INVITATIONS_CREATE_LINK_FAIL:String = "INVITATIONS_CREATE_LINK_FAIL";
		
		public static const INVITATIONS_GET_INFO_SUCCESS:String = "INVITATIONS_GET_INFO_SUCCESS";
		public static const INVITATIONS_GET_INFO_FAIL:String = "INVITATIONS_GET_INFO_FAIL";
		
		public static const NOTIFICATIONS_SEND_SUCCESS:String = "NOTIFICATIONS_SEND_SUCCESS";
		public static const NOTIFICATIONS_SEND_FAIL:String = "NOTIFICATIONS_SEND_FAIL";
		
		public static const NOTIFICATIONS_SEND_EMAIL_SUCCESS:String = "NOTIFICATIONS_SEND_EMAIL_SUCCESS";
		public static const NOTIFICATIONS_SEND_EMAIL_FAIL:String = "NOTIFICATIONS_SEND_EMAIL_FAIL";
		
		public static const PAGES_IS_FAN_SUCCESS:String = "PAGES_IS_FAN_SUCCESS";
		public static const PAGES_IS_FAN_FAIL:String = "PAGES_IS_FAN_FAIL";
		
		public static const PAY_IS_COMPLETED_SUCCESS:String = "PAY_IS_COMPLETED_SUCCESS";
		public static const PAY_IS_COMPLETED_FAIL:String = "PAY_IS_COMPLETED_FAIL";
		
		public static const PAY_REG_ORDER_SUCCESS:String = "PAY_REG_ORDER_SUCCESS";
		public static const PAY_REG_ORDER_FAIL:String = "PAY_REG_ORDER_FAIL";
		
		public static const PAY4TEST_IS_COMPLETED_SUCCESS:String = "PAY4TEST_IS_COMPLETED_SUCCESS";
		public static const PAY4TEST_IS_COMPLETED_FAIL:String = "PAY4TEST_IS_COMPLETED_FAIL";
		
		public static const PAY4TEST_REG_ORDER_SUCCESS:String = "PAY4TEST_REG_ORDER_SUCCESS";
		public static const PAY4TEST_REG_ORDER_FAIL:String = "PAY4TEST_REG_ORDER_FAIL";
		
		public static const USERS_GET_INFO_SUCCESS:String = "USERS_GET_INFO_SUCCESS";
		public static const USERS_GET_INFO_FAIL:String = "USERS_GET_INFO_FAIL";
		
		public static const USERS_GET_LOGGED_IN_USER_SUCCESS:String = "USERS_GET_LOGGED_IN_USER_SUCCESS";
		public static const USERS_GET_LOGGED_IN_USER_FAIL:String = "USERS_GET_LOGGED_IN_USER_FAIL";
		
		public static const USERS_HAS_APP_PERMISSION_SUCCESS:String = "USERS_HAS_APP_PERMISSION_SUCCESS";
		public static const USERS_HAS_APP_PERMISSION_FAIL:String = "USERS_HAS_APP_PERMISSION_FAIL";
		
		public static const USERS_IS_APP_USER_SUCCESS:String = "USERS_IS_APP_USER_SUCCESS";
		public static const USERS_IS_APP_USER_FAIL:String = "USERS_IS_APP_USER_FAIL";
		
		public static const STATUS_GETS_SUCCESS:String = "STATUS_GETS_SUCCESS";
		public static const STATUS_GETS_FAIL:String = "STATUS_GETS_FAIL";
		
		public static const STATUS_SET_SUCCESS:String = "STATUS_SET_SUCCESS";
		public static const STATUS_SET_FAIL:String = "STATUS_SET_FAIL";
		
		public static const STATUS_GET_SUCCESS:String = "STATUS_GET_SUCCESS";
		public static const STATUS_GET_FAIL:String = "STATUS_GET_FAIL";
		
		public static const STATUS_GET_COMMENT_SUCCESS:String = "STATUS_GET_COMMENT_SUCCESS";
		public static const STATUS_GET_COMMENT_FAIL:String = "STATUS_GET_COMMENT_FAIL";
		
		public static const PHOTOS_CREATE_ALBUM_SUCCESS:String = "PHOTOS_CREATE_ALBUM_SUCCESS";
		public static const PHOTOS_CREATE_ALBUM_FAIL:String = "PHOTOS_CREATE_ALBUM_FAIL";
		
		public static const PHOTOS_GET_ALBUMS_SUCCESS:String = "PHOTOS_GET_ALBUMS_SUCCESS";
		public static const PHOTOS_GET_ALBUMS_FAIL:String = "PHOTOS_GET_ALBUMS_FAIL";
		
		public static const PHOTOS_UPLOAD_SUCCESS:String = "PHOTOS_UPLOAD_SUCCESS";
		public static const PHOTOS_UPLOAD_FAIL:String = "PHOTOS_UPLOAD_FAIL";
		
		public static const PHOTOS_GET_SUCCESS:String = "PHOTOS_GET_SUCCESS";
		public static const PHOTOS_GET_FAIL:String = "PHOTOS_GET_FAIL";
		
		public static const PHOTOS_GET_COMMENTS_SUCCESS:String = "PHOTOS_GET_COMMENTS_SUCCESS";
		public static const PHOTOS_GET_COMMENTS_FAIL:String = "PHOTOS_GET_COMMENTS_FAIL";
		
		public static const PHOTOS_ADD_COMMENT_SUCCESS:String = "PHOTOS_ADD_COMMENT_SUCCESS";
		public static const PHOTOS_ADD_COMMENT_FAIL:String = "PHOTOS_ADD_COMMENT_FAIL";
		
		public static const BLOG_ADD_BLOG_SUCCESS:String = "BLOG_ADD_BLOG_SUCCESS";
		public static const BLOG_ADD_BLOG_FAIL:String = "BLOG_ADD_BLOG_FAIL";
		
		public static const BLOG_GETS_SUCCESS:String = "BLOG_GETS_SUCCESS";
		public static const BLOG_GETS_FAIL:String = "BLOG_GETS_FAIL";
		
		public static const BLOG_GET_SUCCESS:String = "BLOG_GET_SUCCESS";
		public static const BLOG_GET_FAIL:String = "BLOG_GET_FAIL";
		
		public static const BLOG_GET_COMMENTS_SUCCESS:String = "BLOG_GET_COMMENTS_SUCCESS";
		public static const BLOG_GET_COMMENTS_FAIL:String = "BLOG_GET_COMMENTS_FAIL";

		public static const BLOG_ADD_COMMENT_SUCCESS:String = "BLOG_ADD_COMMENT_SUCCESS";
		public static const BLOG_ADD_COMMENT_FAIL:String = "BLOG_ADD_COMMENT_FAIL";
		
		/*public static const WIDGET_SUCCESS:String = "WIDGET_SUCCESS";
		public static const WIDGET_FAIL:String = "WIDGET_FAIL";
		
		public static const WIDGET_FEED_SUCCESS:String = "WIDGET_FEED_SUCCESS";
		public static const WIDGET_FEED_FAIL:String = "WIDGET_FEED_FAIL";*/
		
		public static const FEED_DIALOG_SUCCESS:String = "FEED_DIALOG_SUCCESS";
		public static const FEED_DIALOG_FAIL:String = "FEED_DIALOG_FAIL";
		
		public static const REQUEST_DIALOG_SUCCESS:String = "REQUEST_DIALOG_SUCCESS";
		public static const REQUEST_DIALOG_FAIL:String = "REQUEST_DIALOG_FAIL";
		
		public static const STATUS_DIALOG_SUCCESS:String = "STATUS_DIALOG_SUCCESS";
		public static const STATUS_DIALOG_FAIL:String = "STATUS_DIALOG_FAIL";
		
		public static const LIKE_DIALOG_SUCCESS:String = "LIKE_DIALOG_SUCCESS";
		public static const LIKE_DIALOG_FAIL:String = "LIKE_DIALOG_FAIL";
		
		public static const FRIENDS_DIALOG_SUCCESS:String = "FRIENDS_DIALOG_SUCCESS";
		public static const FRIENDS_DIALOG_FAIL:String = "FRIENDS_DIALOG_FAIL";
		
		public var data:Object;
		
		public function RenRenEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			var e:RenRenEvent = new RenRenEvent(type, bubbles, cancelable);
			e.data = this.data;
			return e;
		}
	}
}