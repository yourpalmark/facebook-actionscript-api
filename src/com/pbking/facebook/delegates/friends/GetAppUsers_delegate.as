package com.pbking.facebook.delegates.friends
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	import flash.events.Event;
	
	import mx.logging.Log;

	public class GetAppUsers_delegate extends FacebookDelegate
	{
		public var users:Array;
		
		public function GetAppUsers_delegate(fBook:Facebook)
		{
			super(fBook);
			Log.getLogger("pbking.facebook").debug("getting appUsers");
			
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
				users.push(new FacebookUser(int(xUID)));
			} 
			
			onComplete();
		}
		
	}
}