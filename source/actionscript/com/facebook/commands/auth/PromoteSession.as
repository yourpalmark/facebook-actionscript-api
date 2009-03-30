/**
 * http://wiki.developers.facebook.com/index.php/Auth.promoteSession
 * Feb 18/09
 */ 
package com.facebook.commands.auth {
	
	import com.facebook.net.FacebookCall;

	/**
	 * The PromoteSession class represents the public  
      Facebook API known as Auth.promoteSession.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Auth.promoteSession
	 */
	public class PromoteSession extends FacebookCall {

		
		public static var METHOD_NAME:String = 'auth.promoteSession';
		public static var SCHEMA:Array = [];
		
		public function PromoteSession() {
			super(METHOD_NAME);
		}
	}
}