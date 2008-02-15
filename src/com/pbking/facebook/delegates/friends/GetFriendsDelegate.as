package com.pbking.facebook.delegates.friends
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class GetFriendsDelegate extends FacebookDelegate
	{
		public var friends:Array;
		
		public function GetFriendsDelegate(facebook:Facebook)
		{
			super(facebook);
			fbCall.post("facebook.friends.get");
		}
		
		override protected function handleResult(result:Object):void
		{
			friends = [];
			
			for each(var uid:int in result)
			{
				friends.push(FacebookUser.getUser(uid));
			} 
		}
		
	}
}