package com.facebook.data.events {
	
	[Bindable]
	public class EventData {
		
		public var eid:String;
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
		public var creator:Number;
		public var location:String;
		public var venue:VenueData;

		public var start_time:Date;
		public var end_time:Date;
		public var update_time:Date;
		
		public function EventData() {
				
		}
	}
	
}