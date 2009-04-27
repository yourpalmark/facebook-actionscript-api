/**
 * http://wiki.developers.facebook.com/index.php/Connect.unregisterUsers
 * Feb 20/09
 * 
 */
package com.facebook.commands.connect {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;

	use namespace facebook_internal;
	
	/**
	 * The UnregisterUsers class represents the public  
      Facebook API known as Connect.unregisterUsers.
	 * @see http://wiki.developers.facebook.com/index.php/Connect.unregisterUsers
	 */
	public class UnregisterUsers extends FacebookCall {

		
		public static const METHOD_NAME:String = 'connect.unregisterUsers';
		public static const SCHEMA:Array = ['email_hashes'];
		
		public var email_hashes:Array;
		
		public function UnregisterUsers(email_hashes:Array) {
			super(METHOD_NAME);
			
			this.email_hashes = email_hashes;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, JSON.encode(email_hashes));
			super.facebook_internal::initialize();
		}
	}
}