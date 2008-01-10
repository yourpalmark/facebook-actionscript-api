package com.pbking.facebook.delegates.events
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.events.FacebookEvent;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetEventMembers_delegate extends FacebookDelegate
	{
		public var event:FacebookEvent;

		public function GetEventMembers_delegate(event:FacebookEvent)
		{
			this.event = event;
			
			fbCall.setRequestArgument("eid", event.eid.toString());
			fbCall.post("facebook.events.getMembers");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			super.handleResult(resultXML);
			
			default xml namespace = fBook.FACEBOOK_NAMESPACE;

			var uid:XML;

			event.attending.removeAll();
			for each(uid in resultXML.attending.children())
				event.attending.addUser(fBook.getUser(parseInt(uid)));
			
			event.unsure.removeAll();
			for each(uid in resultXML.unsure.children())
				event.unsure.addUser(fBook.getUser(parseInt(uid)));
			
			event.declined.removeAll();
			for each(uid in resultXML.declined.children())
				event.declined.addUser(fBook.getUser(parseInt(uid)));
			
			event.not_replied.removeAll();
			for each(uid in resultXML.not_replied.children())
				event.not_replied.addUser(fBook.getUser(parseInt(uid)));
			
		}
		
	}
}