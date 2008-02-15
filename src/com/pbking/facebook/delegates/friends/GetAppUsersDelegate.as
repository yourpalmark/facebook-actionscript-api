package com.pbking.facebook.delegates.friends
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	import flash.events.Event;
	
	public class GetAppUsersDelegate extends FacebookDelegate
	{
		public var users:Array;
		
		public function GetAppUsersDelegate(facebook:Facebook)
		{
			super(facebook);
			
			var fbCall:FacebookCall = new FacebookCall(fBook);
			fbCall.addEventListener(Event.COMPLETE, onCallComplete);
			fbCall.post("facebook.friends.getAppUsers");
		}
		
		override protected function handleResult(result:Object):void
		{
			users = [];
			
			for each(var uid:int in result)
			{
				users.push(FacebookUser.getUser(uid));
			} 
		}
		
	}
}