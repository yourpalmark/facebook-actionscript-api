package com.pbking.facebook.delegates.friends
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	import flash.events.Event;
	
	public class GetAppUsers_delegate extends FacebookDelegate
	{
		public var users:Array;
		
		public function GetAppUsers_delegate()
		{
			PBLogger.getLogger("pbking.facebook").debug("getting appUsers");
			
			var fbCall:FacebookCall = new FacebookCall(fBook);
			fbCall.addEventListener(Event.COMPLETE, result);
			fbCall.post("facebook.friends.getAppUsers");
		}
		
		override protected function result(event:Event):void
		{
			var fbCall:FacebookCall = event.target as FacebookCall;

			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			users = [];
			
			var xFriendsList:XMLList = fbCall.getResponse()..uid;
			for each(var xUID:XML in xFriendsList)
			{
				users.push(fBook.getUser(parseInt(xUID)));
			} 
			
			onComplete();
		}
		
	}
}