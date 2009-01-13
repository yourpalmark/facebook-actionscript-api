package com.pbking.facebook.commands.friends
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	
	[Bindable]
	public class GetFriends extends FacebookCall
	{
		public var friends:Array;
		
		public function GetFriends()
		{
			super("facebook.friends.get");
		}
		
		override protected function handleSuccess(result:Object):void
		{
			var myFriends:Array = [];
			
			for each(var uid:int in result)
			{
				myFriends.push(FacebookUser.getUser(uid));
			} 
			
			friends = myFriends;
		}
		
	}
}