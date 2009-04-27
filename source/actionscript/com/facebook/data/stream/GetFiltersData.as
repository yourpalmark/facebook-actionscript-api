package com.facebook.data.stream {
	
	import com.facebook.data.FacebookData;
	
	[Bindable]
	public class GetFiltersData extends FacebookData {
		
		public var filters:StreamFilterCollection;
		
		public function GetFiltersData() {
			super();
		}
		
	}
}