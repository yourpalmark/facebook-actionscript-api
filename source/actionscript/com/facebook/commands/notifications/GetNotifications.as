/**
 * http://wiki.developers.facebook.com/index.php/Notifications.get
 * Feb 10/09
 */ 
package com.facebook.commands.notifications {
	
	import com.facebook.net.FacebookCall;
	
	/**
	 * The GetNotifications class represents the public  
      Facebook API known as Notifications.get.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Notifications.get
	 */
	public class GetNotifications extends FacebookCall {

		
		public static const METHOD_NAME:String = 'notifications.get';
		public static const SCHEMA:Array = [];
		
		public function GetNotifications() {
			super(METHOD_NAME);
		}
		
		
	}
}