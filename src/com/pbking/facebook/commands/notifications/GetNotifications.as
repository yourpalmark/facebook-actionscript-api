package com.pbking.facebook.commands.notifications
{
	import com.pbking.facebook.FacebookCall;

	[Bindable]	
	public class GetNotifications extends FacebookCall
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