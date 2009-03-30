package com.facebook.data.fbml {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetCustomTagsData extends FacebookData {
		
		public var tagCollection:TagCollection;
		
		public function GetCustomTagsData() {
			super();
		}
		
	}
}