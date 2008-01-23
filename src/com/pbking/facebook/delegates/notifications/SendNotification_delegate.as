package com.pbking.facebook.delegates.notifications
{
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class SendNotification_delegate extends FacebookDelegate
	{
		public function SendNotification_delegate(notification:String, users:Array=null)
		{
			PBLogger.getLogger("pbking.facebook").debug("sending notification");
			
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