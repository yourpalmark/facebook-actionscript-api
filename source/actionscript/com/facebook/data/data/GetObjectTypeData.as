package com.facebook.data.data {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetObjectTypeData extends FacebookData {
		
		public var name:String;
		public var data_type:Number;
		public var index_type:Number;
		
		public function GetObjectTypeData() {
			super();
		}
		
	}
}