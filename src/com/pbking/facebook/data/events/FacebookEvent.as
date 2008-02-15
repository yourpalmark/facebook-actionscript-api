package com.pbking.facebook.data.events
{
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.users.FacebookUserCollection;
	import com.pbking.util.collection.HashableArray;
	
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
			if(_locked)
				throw new Error("an event should be created by calling FacebookEvent.getEvent(eid) so that there is only ever a single instance of each event");

			this.eid = eid;
			
			//making sure it's imported
			RSVP_Status;
		}

		/**
		 * This keeps a common collection of events so that all information gathered
		 * on events is stored here and updated.  Each event should have only one instance.
		 * 
		 * Creating an event should happen from this method.
		 */
		public static function getEvent(eid:Number):FacebookEvent
		{
			var event:FacebookEvent = _eventCollection.getItemById(eid) as FacebookEvent;
			if(!event)
			{
				_locked = false;
				event = new FacebookEvent(eid);
				_locked = true;
				_eventCollection.addItem(event);
			}
			return event;
		}
		
		private static var _eventCollection:HashableArray = new HashableArray('eid', false);
		private static var _locked:Boolean = true;
	}
}