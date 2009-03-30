package com.facebook.data.auth {
	
	import com.facebook.data.FacebookData;
	
	[Bindable]
	public class GetSessionData extends FacebookData {
		
		public var session_key:String;
		public var uid:String;
		public var expires:Date;
		public var secret:String;
		
		public function GetSessionData() {
			super();
		}
		
	}
}