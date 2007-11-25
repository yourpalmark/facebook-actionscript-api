package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	import flash.events.Event;
	
	import mx.logging.Log;

	public class GetLoggedInUser_delegate extends FacebookDelegate
	{
		public var user:FacebookUser;
		
		public function GetLoggedInUser_delegate(fBook:Facebook)
		{
			super(fBook);
			Log.getLogger("pbking.facebook").debug("getting logged in user");
			
			var fbCall:FacebookCall = new FacebookCall(fBook);
			fbCall.addEventListener(Event.COMPLETE, result);
			fbCall.post("facebook.users.getLoggedInUser");
		}
		
		override protected function result(event:Event):void
		{
			var fbCall:FacebookCall = event.target as FacebookCall;

			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			var newUserId:int = parseInt(fbCall.getResponse().toString());
			
			user = new FacebookUser(newUserId);
						
			onComplete();
		}
		
	}
}