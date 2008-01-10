package com.pbking.facebook.delegates.events
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.events.FacebookEvent;
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.util.FacebookDataParser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetEvents_delegate extends FacebookDelegate
	{
		public var user:FacebookUser;
		public var eventsFilter:Array;
		public var start_time:Date;
		public var end_time:Date;
		public var rsvp_status_filter:String;
		
		public var events:Array;
		
		public function GetEvents_delegate(user:FacebookUser=null, eventsFilter:Array=null, start_time:Date=null, end_time:Date=null, rsvp_status_filter:String="")
		{
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
		
		override protected function handleResult(resultXML:XML):void
		{
			super.handleResult(resultXML);
			
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			events = [];
			
			for each(var eventX:XML in resultXML..event)
			{
				var newEvent:FacebookEvent = fBook.getEvent(eventX.eid);
				events.push(newEvent);
				
				if(eventX.name != undefined)
					newEvent.name = eventX.name;
				
				if(eventX.nid != undefined)
					newEvent.nid = eventX.nid;
				
				if(eventX.description != undefined)
					newEvent.description = eventX.description;
				
				if(eventX.event_type != undefined)
					newEvent.event_type = eventX.event_type;
				
				if(eventX.event_subtype != undefined)
					newEvent.event_subtype = eventX.event_subtype;
				
				if(eventX.pic != undefined)
					newEvent.pic = eventX.pic;
				
				if(eventX.pic_big != undefined)
					newEvent.pic_big = eventX.pic_big;
				
				if(eventX.pic_small != undefined)
					newEvent.pic_small = eventX.pic_small;

				if(eventX.creator != undefined)
					newEvent.creator = fBook.getUser(parseInt(eventX.creator));;
				
				if(eventX.update_time != undefined)
					newEvent.update_time = FacebookDataParser.formatDate(eventX.update_time);
				
				if(eventX.venue != undefined)
				{
					newEvent.venue = new FacebookLocation();
					newEvent.venue.street = eventX.venue.street;
					newEvent.venue.city = eventX.venue.city;
					newEvent.venue.state = eventX.venue.state;
					newEvent.venue.country = eventX.venue.country;
					newEvent.venue.zip = eventX.venue.zip;
				}

			}
			
		}
		
	}
}