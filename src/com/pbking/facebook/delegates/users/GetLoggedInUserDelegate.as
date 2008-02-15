package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class GetLoggedInUserDelegate extends FacebookDelegate
	{
		public var user:FacebookUser;
		
		public function GetLoggedInUserDelegate(facebook:Facebook)
		{
			super(facebook);
			
			fbCall.post("facebook.users.getLoggedInUser");
		}
		
		override protected function handleResult(result:Object):void
		{
			var newUserId:int = parseInt(result.toString());			
			user = FacebookUser.getUser(newUserId);
			user.isLoggedInUser = true;
		}
		
	}
}