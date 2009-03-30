/**
 * http://wiki.developers.facebook.com/index.php/Friends.getAppUsers
 * Feb 10/09
 */ 
package com.facebook.commands.friends {
	
	import com.facebook.data.friends.GetAppUserData;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.net.FacebookCall;
	
	/**
	 * The GetAppUsers class represents the public  
      Facebook API known as Friends.getAppUsers.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Friends.getAppUsers
	 */
	public class GetAppUsers extends FacebookCall {

		
		public static var METHOD_NAME:String = 'friends.getAppUsers';
		public static var SCHEMA:Array = [];
		
		public function GetAppUsers() {
			super(METHOD_NAME);
		}
		
	}
}