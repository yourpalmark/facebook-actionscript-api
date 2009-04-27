package com.facebook.commands.users {
	
	import com.facebook.data.friends.GetLoggedInUserData;
	import com.facebook.net.FacebookCall;
	
	/**
	 * The GetLoggedInUser class represents the public  
      Facebook API known as Users.getLoggedInUser.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Users.getLoggedInUser
	 */
	public class GetLoggedInUser extends FacebookCall {

		
		public static const METHOD_NAME:String = 'users.getLoggedInUser';
		public static const SCHEMA:Array = [];
		
		public function GetLoggedInUser() {
			super(METHOD_NAME);
		}
	}
}