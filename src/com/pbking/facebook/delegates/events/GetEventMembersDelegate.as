package com.pbking.facebook.delegates.events
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.events.FacebookEvent;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetEventMembersDelegate extends FacebookDelegate
	{
		public var event:FacebookEvent;

		public function GetEventMembersDelegate(facebook:Facebook, event:FacebookEvent)
		{
			super(facebook);
			
			this.event = event;
			
			fbCall.setRequestArgument("eid", event.eid.toString());
			fbCall.post("facebook.events.getMembers");
		}
		
		override protected function handleResult(result:Object):void
		{
			var uid:int;

			event.attending.removeAll();
			for each(uid in result.attending)
				event.attending.addUser(FacebookUser.getUser(uid));
			
			event.unsure.removeAll();
			for each(uid in result.unsure)
				event.unsure.addUser(FacebookUser.getUser(uid));
			
			event.declined.removeAll();
			for each(uid in result.declined)
				event.declined.addUser(FacebookUser.getUser(uid));
			
			event.not_replied.removeAll();
			for each(uid in result.not_replied)
				event.not_replied.addUser(FacebookUser.getUser(uid));
			
		}
		
	}
}