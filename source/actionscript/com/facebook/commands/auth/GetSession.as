/**
 * http://wiki.developers.facebook.com/index.php/Admin.getSession
 * Feb 18/09
 * 
 * This command should only be called internally.
 */
package com.facebook.commands.auth {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;
	
	use namespace facebook_internal;
	
	/**
	 * The GetSession class represents the public  
      Facebook API known as Auth.getSession.
	 * @see http://wiki.developers.facebook.com/index.php/Auth.getSession
	 */
	public class GetSession extends FacebookCall {

		
		public static const METHOD_NAME:String = 'auth.getSession';
		public static const SCHEMA:Array = ['auth_token'];
		
		public var auth_token:String;
		
		public function GetSession(auth_token:String) {
			super(METHOD_NAME);
			
			this.auth_token = auth_token;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, auth_token);
			super.facebook_internal::initialize();
		}
	}
}