package com.facebook.data.events{
	
	import com.facebook.data.FacebookData;
	
	[Bindable]
	public class GetMembersData extends FacebookData {
		
		public var attending:Array;
		public var unsure:Array;
		public var declined:Array;
		public var not_replied:Array;
		
		public function GetMembersData() {
			super();
		}
		
	}
}