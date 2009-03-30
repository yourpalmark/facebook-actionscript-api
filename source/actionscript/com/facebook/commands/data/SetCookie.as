/**
 * http://wiki.developers.facebook.com/index.php/Data.setCookie
 * Feb 20/09
 * Updated: Feb 27.09
 *  	   - adding uid param
 */
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The SetCookie class represents the public  
      Facebook API known as Data.setCookie.
	 * @see http://wiki.developers.facebook.com/index.php/Data.setCookie
	 */
	public class SetCookie extends FacebookCall {

		
		public static var METHOD_NAME:String = 'data.setCookie';
		public static var SCHEMA:Array = ['uid','name', 'value', 'expires', 'path'];
		
		public var uid:String;
		public var name:String;
		public var value:String;
		public var expires:Date;
		public var path:String;
		
		public function SetCookie(uid:String, name:String, value:String, expires:Date = null, path:String = '/') {
			super(METHOD_NAME);
			
			this.uid = uid;
			this.name = name;
			this.value = value;
			this.expires = expires;
			this.path = path;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid, name, value, FacebookDataUtils.toDateString(expires), path);
			super.facebook_internal::initialize();
		}		
	}
}