package com.pbking.facebook.commands.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.util.logging.PBLogger;
	import com.pbking.facebook.FacebookCall;
	
	[Bindable]	
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