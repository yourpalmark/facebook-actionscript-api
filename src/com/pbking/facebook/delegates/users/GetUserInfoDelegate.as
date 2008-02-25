package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.misc.FacebookEducationInfo;
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.misc.FacebookNetwork;
	import com.pbking.facebook.data.misc.FacebookWorkInfo;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.util.FacebookDataParser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetUserInfoDelegate extends FacebookDelegate
	{
		public var users:Array;
		
		function GetUserInfoDelegate(facebook:Facebook, users:Array, fields:Array)
		{
			super(facebook);
			
			this.users = users;
			var uids:Array = [];

			//put all of the users uids into an array to send
			//we can handle either FacebookUser types or ints (uids)
			for(var i:int=0; i<users.length; i++)
				uids.push(users[i] is FacebookUser ? users[i].uid : users[i]);

			fbCall.setRequestArgument("uids", uids.join(","));
			fbCall.setRequestArgument("fields", fields.join(","));

			fbCall.post("facebook.users.getInfo");
			
		}
		
		override protected function handleResult(result:Object):void
		{
			for each(var user:Object in result)
			{
				var modUser:FacebookUser = FacebookUser.getUser(parseInt(user.uid));
				modUser.parseProperties(user);
			}
			
		}
		
	}
}