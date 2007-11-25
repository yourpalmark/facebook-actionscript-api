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
			
			fbCall.post("facebook.users.getLoggedInUser");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			var newUserId:int = parseInt(resultXML.toString());			
			user = new FacebookUser(newUserId);
		}
		
	}
}