package com.facebook.data.groups  {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetGroupData extends FacebookData {
		
		public var groups:GroupCollection;
		
		public function GetGroupData() {
			super();
		}
		
	}
}