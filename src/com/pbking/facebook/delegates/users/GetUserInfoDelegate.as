package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetUserInfoDelegate extends FacebookDelegate
	{
		public var users:Array = [];
		
		function GetUserInfoDelegate(facebook:Facebook, users:Array, fields:Array)
		{
			super(facebook);
			
			var uids:Array = [];

			//put all of the users uids into an array to send
			//we can handle either FacebookUser types or ints (uids)
			for(var i:int=0; i<users.length; i++)
				uids.push(users[i] is FacebookUser ? users[i].uid : users[i]);
				
			//now go ahead and stuff the users in the users array so we can use it now
			for(var j:int=0; j<uids.length; j++)
				users.push(FacebookUser.getUser(uids[j]));

			fbCall.setRequestArgument("uids", uids.join(","));
			fbCall.setRequestArgument("fields", fields.join(","));

			fbCall.post("facebook.users.getInfo");
			
		}
		
		override protected function handleResult(result:Object):void
		{
			users = [];
			for each(var user:Object in result)
			{
				var modUser:FacebookUser = FacebookUser.getUser(parseInt(user.uid));
				modUser.parseProperties(user);
				users.push(modUser);
			}
			
		}
		
	}
}