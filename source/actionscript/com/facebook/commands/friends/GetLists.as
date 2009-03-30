/**
 * http://wiki.developers.facebook.com/index.php/Friends.getLists
 * Feb 18/09; 
 */
package com.facebook.commands.friends {
	
	import com.facebook.net.FacebookCall;
	
	/**
	 * The GetLists class represents the public  
      Facebook API known as Friends.getLists.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Friends.getLists
	 */
	public class GetLists extends FacebookCall {

		
		public static var METHOD_NAME:String = 'friends.getLists';
		public static var SCHEMA:Array = [];
		
		public function GetLists() {
			super(METHOD_NAME);
		}
	}
}