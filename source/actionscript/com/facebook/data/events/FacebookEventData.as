package com.facebook.data.events {
	
	import com.facebook.data.FacebookLocation;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.data.users.FacebookUserCollection;
	
	[Bindable]
	public class FacebookEventData {

		

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

		public var creator:FacebookUser;

		public var location:String;

		public var venue:FacebookLocation;



		public var start_time:Date;

		public var end_time:Date;

		public var update_time:Date;

		

		public var attending:FacebookUserCollection

		public var unsure:FacebookUserCollection;

		public var declined:FacebookUserCollection;

		public var not_replied:FacebookUserCollection;

		

		public function FacebookEventData(eid:String):void {

			this.eid = eid;

		}
	}
}