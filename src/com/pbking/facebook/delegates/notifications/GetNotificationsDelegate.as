package com.pbking.facebook.delegates.notifications
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class GetNotificationsDelegate extends FacebookDelegate
	{
		
		public var notifications:Object = new Object();
		public var notificationLists:Object = new Object();
		
		public function GetNotificationsDelegate(facebook:Facebook)
		{
			super(facebook);
			
			fbCall.post("facebook.notifications.get");
		}
		
		override protected function handleResult(result:Object):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			//TODO: write this for JSON handling
		}
		
	}
}