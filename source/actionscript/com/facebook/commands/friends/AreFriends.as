/**
 * http://wiki.developers.facebook.com/index.php/Friends.areFriends
 * Feb 10/09
 */ 
package com.facebook.commands.friends {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The AreFriends class represents the public  
      Facebook API known as Friends.areFriends.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Friends.areFriends
	 */
	public class AreFriends extends FacebookCall {

		
		public static var METHOD_NAME:String = 'friends.areFriends';
		public static var SCHEMA:Array = ['uids1', 'uids2','format'];
		
		public var uids1:Array;
		public var uids2:Array;
		public var format:String;
		
		public function AreFriends(uids1:Array, uids2:Array,format:String) {
			super(METHOD_NAME);
			
			this.uids1 = uids1;
			this.uids2 = uids2;
			this.format = format;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(uids1), FacebookDataUtils.toArrayString(uids2), format);
			super.facebook_internal::initialize();
		}
	}
}