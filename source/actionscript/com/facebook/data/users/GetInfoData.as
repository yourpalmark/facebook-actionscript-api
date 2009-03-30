package com.facebook.data.users {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetInfoData extends FacebookData {
		
		public var userCollection:FacebookUserCollection;
		
		public function GetInfoData() {
			super();
		}
		
	}
}