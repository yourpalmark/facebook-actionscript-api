package com.facebook.data.admin {
	
	import com.facebook.data.FacebookData;
	
	[Bindable]
	public class GetAllocationData extends FacebookData {
		
		public var allocationLimit:Number;
		
		public function GetAllocationData() {
			super();
		}
		
	}
}