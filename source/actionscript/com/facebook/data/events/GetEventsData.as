package com.facebook.data.events {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetEventsData extends FacebookData {
		
		public var eventCollection:EventCollection;
		
		public function GetEventsData() {
			super();
		}
		
	}
}