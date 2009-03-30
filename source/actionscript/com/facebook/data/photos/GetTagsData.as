package com.facebook.data.photos {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetTagsData extends FacebookData {
		
		public var photoTagsCollection:PhotoTagCollection;
		
		public function GetTagsData() {
			super();
		}
		
	}
}