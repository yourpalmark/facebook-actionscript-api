package com.pbking.facebook.commands.friends
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	
	[Bindable]
	public class GetAppUsers extends FacebookCall
	{
		public var uids:Array;
		public var users:Array;
		
		public function GetAppUsers()
		{
			super("facebook.friends.getAppUsers");
		}
		
		override protected function handleSuccess(result:Object):void
		{
			uids = [];
			users = [];
			
			for each(var uid:int in result)
			{
				uids.push(uid);
				users.push(FacebookUser.getUser(uid));
			} 
		}
		
	}
}