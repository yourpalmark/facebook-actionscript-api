/**
 * http://wiki.developers.facebook.com/index.php/Users.isAppUser
 * Feb: 16/09
 */
package com.facebook.commands.users {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	
	/**
	 * The IsAppUser class represents the public  
      Facebook API known as Users.isAppUser.
	 * @see http://wiki.developers.facebook.com/index.php/Users.isAppUser
	 */
	public class IsAppUser extends FacebookCall {

		
		public static const METHOD_NAME:String = 'users.isAppUser';
		public static const SCHEMA:Array = ['uid'];
		
		public var uid:String;
		
		public function IsAppUser(uid:String=null) {
			super(METHOD_NAME);
			
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid);
			super.facebook_internal::initialize();
		}
	}
}