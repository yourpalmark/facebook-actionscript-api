package com.facebook.data.events {
	
	[Bindable]
	public class EditEventData {
		
		public var city:String;
		public var subcategory:String;
		public var category:String;
		public var host:String;
		public var location:String;
		public var start_time:Date;
		public var end_time:Date;
		public var street:String;
		public var phone:String;
		public var email:String;
		public var host_id:Number;
		public var description:String;
		public var privacy_type:String;
		public var tagline:String;
		
		public var schema:Array;
	
		public function EditEventData(city:String, category:String, subcategory:String, host:String, 
								      location:String, start_time:Date, end_time:Date,
									  street:String = null, phone:String = null, email:String = null, 
									  host_id:Number = NaN, description:String = null, privacy_type:String = null, 
									  tagline:String = null 
										) {
			schema = ['city', 'category', 'subcategory', 'host', 
					  'location', 'start_time', 'end_time', 'street', 
					  'phone', 'email', 'host_id', 'description', 'privacy_type', 'tagline']
			this.city = city;
			this.category = category;
			this.subcategory = subcategory;
			this.host = host;
			this.location = location;
			this.start_time = start_time;
			this.end_time = end_time;
			
			//Optional
			this.street = street
			this.phone = phone;
			this.email= email;
			this.host_id = host_id;
			this.description = description;
			this.privacy_type = privacy_type;
			this.tagline = tagline;

		}
	
	}
}