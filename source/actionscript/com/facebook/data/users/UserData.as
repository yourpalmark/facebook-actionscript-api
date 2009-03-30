package com.facebook.data.users {
	
	[Bindable]
	public class UserData {
		
		public var uid:Number;
		public var affiations:AffiliationCollection;
		public var first_name:String;
		public var last_name:String;
		public var name:String;
		public var timezone:Number;
		
		public function UserData() {
			
		}
		
		public function toString():String {
			return '[ UserData uid: ' + uid + ' affiation:' + affiations + ' first_name:' + first_name + ' last_name:' + last_name + ' name:' + name + ' timezone: ' + timezone + ']'; 
		}

	}
}