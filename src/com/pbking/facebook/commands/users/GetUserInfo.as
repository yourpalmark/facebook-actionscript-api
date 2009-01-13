package com.pbking.facebook.commands.users
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.IFacebookCallDelegate;
	import com.pbking.facebook.session.IFacebookSession;

	[Bindable]
	public class GetUserInfo extends FacebookCall
	{
		public var users:Array = [];
		public var fields:Array = [];
		
		function GetUserInfo(users:Array=null, fields:Array=null)
		{
			super("facebook.users.getInfo");
			
			this.users = users;
			this.fields = fields;
		}
		
		override public function initialize():void
		{
			var uids:Array = [];

			//put all of the users uids into an array to send
			//we can handle either FacebookUser types or ints (uids)
			for(var i:int=0; i<users.length; i++)
				uids.push(users[i] is FacebookUser ? users[i].uid : users[i]);
			
			clearRequestArguments();
			
			this.setRequestArgument("uids", uids.join(","));
			this.setRequestArgument("fields", fields.join(","));

		}
		
		override protected function handleSuccess(result:Object):void
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