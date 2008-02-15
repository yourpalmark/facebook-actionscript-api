package com.pbking.facebook.delegates.notifications
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	public class SendNotificationDelegate extends FacebookDelegate
	{
		public function SendNotificationDelegate(facebook:Facebook, notification:String, users:Array=null)
		{
			super(facebook);
			
			fbCall.setRequestArgument("notification", notification);
			
			if(users)
			{
				var to_ids:Array = [];
				for each(var fbu:FacebookUser in users)
					to_ids.push(fbu.uid);
				fbCall.setRequestArgument("to_ids", to_ids.join(","));
			}
			else
			{
				fbCall.setRequestArgument("to_ids", "");
			}
			
			fbCall.post("facebook.notifications.send");
		}		
	}
}