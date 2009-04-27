/**
 * http://wiki.developers.facebook.com/index.php/Auth.revokeAuthorization
 * Feb 18/09
 */ 
package com.facebook.commands.auth {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The RevokeAuthorization class represents the public  
      Facebook API known as Auth.revokeAuthorization.
	 * @see http://wiki.developers.facebook.com/index.php/Auth.revokeAuthorization
	 */
	public class RevokeAuthorization extends FacebookCall {

		
		public static const METHOD_NAME:String = 'auth.revokeAuthorization';
		public static const SCHEMA:Array = ['user'];
		
		public var user:String;
		
		public function RevokeAuthorization(user:String=null) {
			super(METHOD_NAME);
			
			this.user = user; 
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, user);
			super.facebook_internal::initialize();
		}
	}
}