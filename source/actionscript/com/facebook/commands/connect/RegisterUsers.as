/**
 * http://wiki.developers.facebook.com/index.php/Connect.getUnconnectedFriendsCount
 * Feb 20/09
 * 
 */
package com.facebook.commands.connect {
	
	import com.facebook.data.connect.ConnectAccountMapCollection;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;

	use namespace facebook_internal;
	
	/**
	 * The RegisterUsers class represents the public  
      Facebook API known as Connect.registerUsers.
	 * @see http://wiki.developers.facebook.com/index.php/Connect.registerUsers
	 */
	public class RegisterUsers extends FacebookCall {

		
		public static const METHOD_NAME:String = 'connect.registerUsers';
		public static const SCHEMA:Array = ['accounts'];
		
		public var accounts:ConnectAccountMapCollection;
		
		public function RegisterUsers(accounts:ConnectAccountMapCollection) {
			super(METHOD_NAME);
			
			this.accounts = accounts;
		}
		
		override facebook_internal function initialize():void {
			var users:String = FacebookDataUtils.facebookCollectionToJSONArray(accounts);
			applySchema(SCHEMA, users);
			super.facebook_internal::initialize();
		}
	}
}