package com.pbking.facebook.data.events
{
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.users.FacebookUserCollection;
	
	[Bindable]
	public class FacebookEvent
	{
		public var eid:Number;
		public var nid:Number;
		
		public var name:String;
		public var tagline:String;
		public var description:String;

		public var event_type:String;
		public var event_subtype:String;

		public var pic:String;
		public var pic_big:String;
		public var pic_small:String;

		public var host:String;
		public var creator:FacebookUser;
		public var location:String;
		public var venue:FacebookLocation;

		public var start_time:Date;
		public var end_time:Date;
		public var update_time:Date;
		
		public var attending:FacebookUserCollection = new FacebookUserCollection();
		public var unsure:FacebookUserCollection = new FacebookUserCollection();
		public var declined:FacebookUserCollection = new FacebookUserCollection();
		public var not_replied:FacebookUserCollection = new FacebookUserCollection();
		
		function FacebookEvent(eid:Number):void
		{
			this.eid = eid;
			
			//making sure it's imported
			RSVP_Status;
		}
	}
}