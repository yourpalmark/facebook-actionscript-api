package com.facebook.data.friends {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetLoggedInUserData extends FacebookData {
		
		public var loggedInUser:Number;
		
		public function GetLoggedInUserData() {
			super();
		}
		
	}
}