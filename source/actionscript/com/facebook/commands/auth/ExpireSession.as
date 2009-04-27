/**
 * http://wiki.developers.facebook.com/index.php/Admin.expireSession
 * Feb 18/09
 */ 
package com.facebook.commands.auth {
	
	import com.facebook.net.FacebookCall;

	/**
	 * The ExpireSession class represents the public  
      Facebook API known as Auth.expireSession.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Auth.expireSession
	 */
	public class ExpireSession extends FacebookCall {

		
		public static const METHOD_NAME:String = 'auth.expireSession';
		public static const SCHEMA:Array = [];
		
		public function ExpireSession() {
			super(METHOD_NAME);
		}
	}
}