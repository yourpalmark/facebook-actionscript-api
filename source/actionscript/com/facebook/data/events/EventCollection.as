package com.facebook.data.events {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class EventCollection extends FacebookArrayCollection {
		
		public function EventCollection() {
			super(null, EventData);
		}
		
	}
}