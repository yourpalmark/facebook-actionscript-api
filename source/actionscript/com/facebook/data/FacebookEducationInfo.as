package com.facebook.data {
	
	[Bindable]
	public class FacebookEducationInfo {
		
		public var name:String;
		public var year:String;
		public var concentrations:Array;
		
		public function FacebookEducationInfo() {
			concentrations = [];
		}
		
	}
}