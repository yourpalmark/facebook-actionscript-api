package com.facebook.data.groups {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetMemberData extends FacebookData {
		
		public var members:Array;
		public var admins:Array;
		public var officers:Array;
		public var notReplied:Array;
		
		public function GetMemberData() {
			super();
		}
		
	}
}