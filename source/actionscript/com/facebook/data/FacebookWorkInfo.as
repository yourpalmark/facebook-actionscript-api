package com.facebook.data {
		
	[Bindable]
	public class FacebookWorkInfo {
		
		public var location:FacebookLocation;
		public var company_name:String;
		public var position:String;
		public var description:String;
		public var start_date:Date;
		public var end_date:Date;
		
		public function FacebookWorkInfo() {
			super();
		}
		
	}
}