package com.pbking.facebook.delegates.events
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.events.FacebookEvent;
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.util.FacebookDataParser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetEventsDelegate extends FacebookDelegate
	{
		public var user:FacebookUser;
		public var eventsFilter:Array;
		public var start_time:Date;
		public var end_time:Date;
		public var rsvp_status_filter:String;
		
		public var events:Array = [];
		
		public function GetEventsDelegate(facebook:Facebook, user:FacebookUser=null, eventsFilter:Array=null, start_time:Date=null, end_time:Date=null, rsvp_status_filter:String="")
		{
			super(facebook);
			
			this.user = user;
			this.eventsFilter = eventsFilter;
			this.start_time = start_time;
			this.end_time = end_time;
			this.rsvp_status_filter = rsvp_status_filter;
			
			if(user)
				fbCall.setRequestArgument("uid", user.uid.toString());
				
			if(eventsFilter)
			{
				var eids:Array = [];
				for each(var e:FacebookEvent in eventsFilter)
					eids.push(e.eid);
					
				if(eids.length > 0)
					fbCall.setRequestArgument("eids", eids.join(","));
			}
			
			if(start_time)
				fbCall.setRequestArgument("start_time", start_time.dateUTC.toString());
			
			if(end_time)
				fbCall.setRequestArgument("end_time", end_time.dateUTC.toString());
			
			if(rsvp_status_filter != "")
				fbCall.setRequestArgument("rsvp_status", rsvp_status_filter);
			
			fbCall.post("facebook.events.get");
		}
		
		override protected function handleResult(result:Object):void
		{
			for each(var event:Object in result)
			{
				var newEvent:FacebookEvent = FacebookEvent.getEvent(event.eid);
				events.push(newEvent);
				
				if(event.name)
					newEvent.name = event.name;
				
				if(event.nid)
					newEvent.nid = event.nid;
				
				if(event.description)
					newEvent.description = event.description;
				
				if(event.event_type)
					newEvent.event_type = event.event_type;
				
				if(event.event_subtype)
					newEvent.event_subtype = event.event_subtype;
				
				if(event.pic)
					newEvent.pic = event.pic;
				
				if(event.pic_big)
					newEvent.pic_big = event.pic_big;
				
				if(event.pic_small)
					newEvent.pic_small = event.pic_small;

				if(event.creator)
					newEvent.creator = FacebookUser.getUser(parseInt(event.creator));;
				
				if(event.update_time)
					newEvent.update_time = FacebookDataParser.formatDate(event.update_time);
				
				if(event.venue)
				{
					newEvent.venue = new FacebookLocation();
					newEvent.venue.street = event.venue.street;
					newEvent.venue.city = event.venue.city;
					newEvent.venue.state = event.venue.state;
					newEvent.venue.country = event.venue.country;
					newEvent.venue.zip = event.venue.zip;
				}

			}
			
		}
		
	}
}