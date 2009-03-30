package com.facebook.data.users {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetStandardInfoData extends FacebookData {
		
		public var userCollection:UserCollection;
		
		public function GetStandardInfoData() {
			super();
		}
		
	}
}