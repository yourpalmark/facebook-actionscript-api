package com.facebook.data.friends {
	
	import com.facebook.data.FacebookData;
	
	[Bindable]
	public class GetAppUserData extends FacebookData {
		
		public var uids:Array;
		
		public function GetAppUserData() {
			super();
		}

	}
}