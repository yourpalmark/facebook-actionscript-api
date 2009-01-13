package com.pbking.facebook.delegates.notifications
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	
	public class SendNotification extends FacebookCall
	{
		public var notification:String;
		public var users:Array;
		public var type:String;
		
		public function SendNotification(notification:String=null, users:Array=null, type:String=null)
		{
			super("facebook.notifications.send");
			
			this.notification = notification;
			this.users = users;
		}
		
		override public function initialize():void
		{
			setRequestArgument("notification", notification);
			
			if(type)
				setRequestArgument("type", type);
			
			if(users && users.length > 0)
			{
				var uids:Array = [];
				
				for(var i:int=0; i<users.length; i++)
				{
					if(users[i] is FacebookUser)
						uids.push(users[i].uid)
					else
						uids.push(users[i]);
				}
				
				setRequestArgument("to_ids", uids.join(","));
			}
			else
			{
				fbCall.setRequestArgument("to_ids", "");
			}
			
		}		
	}
}