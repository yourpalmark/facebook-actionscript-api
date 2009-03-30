package com.facebook.data.pages {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetPageInfoData extends FacebookData {
		
		public var pageInfoCollection:PageInfoCollection;
		
		public function GetPageInfoData() {
			super();
		}
		
	}
}