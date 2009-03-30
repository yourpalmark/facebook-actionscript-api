package com.facebook.data.data {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetObjectTypesData extends FacebookData {
		
		public var objectTypeCollection:ObjectTypesCollection;
		
		public function GetObjectTypesData() {
			super();
		}
		
	}
}