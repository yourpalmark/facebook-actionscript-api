package com.facebook.data.status {
	
	import com.facebook.data.FacebookData;
	
	[Bindable]
	public class GetStatusData extends FacebookData {
		
		public var status:Array;
		
		public function GetStatusData() {
			super();
		}
		
	}
}