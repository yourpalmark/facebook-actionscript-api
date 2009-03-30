package com.facebook.data.admin {
	
	import com.facebook.data.FacebookData;
	
	[Bindable]
	public class GetAppPropertiesData extends FacebookData {
		
		public var appProperties:Array;
		
		public function GetAppPropertiesData() {
			super();
		}
		
	}
}