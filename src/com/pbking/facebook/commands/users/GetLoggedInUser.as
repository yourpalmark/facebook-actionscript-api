package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	import com.pbking.facebook.FacebookCall;
	
	public class GetLoggedInUser extends FacebookCall
	{
		public var user:FacebookUser;
		public var uid:uint;
		
		public function GetLoggedInUser(facebook:Facebook)
		{
			super("facebook.users.getLoggedInUser");
		}
		
		override protected function handleSuccess(result:Object):void
		{
			uid = parseInt(result.toString());			
			user = FacebookUser.getUser(uid);
			user.isLoggedInUser = true;
		}
		
	}
}