/**
 * Generates a Token to be used to login into Facebook from Desktop applications.
 * Note: Your application must be set as a desktop application  In your Advanced application settings.
 * http://wiki.developers.facebook.com/index.php/Auth.createToken
 * Feb 10/09
 */
package com.facebook.commands.auth {
	
	import com.facebook.net.FacebookCall;
	import flash.net.URLVariables;
	
	/**
	 * The CreateToken class represents the public  
      Facebook API known as Auth.createToken.
	 * @see http://wiki.developers.facebook.com/index.php/Auth.createToken
	 */
	public class CreateToken extends FacebookCall {

		
		public static var METHOD_NAME:String = 'auth.createToken';
		public static var SCHEMA:Array = [];
		
		public function CreateToken() {
			super(METHOD_NAME);
		}
		
	}
}