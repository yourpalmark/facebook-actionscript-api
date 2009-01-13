package com.pbking.facebook.delegates.notifications
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class GetNotifications extends FacebookDelegate
	{
		
		public var notifications:Object = new Object();
		public var notificationLists:Object = new Object();
		
		public function GetNotifications()
		{
			super("facebook.notifications.get");
		}
		
		override protected function handleSuccess(result:Object):void
		{
			//TODO: handle notifications
		}
		
	}
}