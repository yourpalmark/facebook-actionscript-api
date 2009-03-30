/**
 * http://wiki.developers.facebook.com/index.php/Connect.getUnconnectedFriendsCount
 * Feb 20/09
 * 
 */
package com.facebook.commands.connect {
	
	import com.facebook.net.FacebookCall;
	
	/**
	 * The GetUnconnectedFriendsCount class represents the public  
      Facebook API known as Connect.getUnconnectedFriendsCount.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Connect.getUnconnectedFriendsCount
	 */
	public class GetUnconnectedFriendsCount extends FacebookCall {

		
		public static var METHOD_NAME:String = 'connect.getUnconnectedFriendsCount';
		public static var SCHEMA:Array = [];
		
		public function GetUnconnectedFriendsCount() {
			super(METHOD_NAME);
		}
	}
}