package com.facebook.commands.data {
	
	import com.facebook.data.FacebookData;

	public class GetCookiesData extends FacebookData {
		
		public var uid:String;
		public var name:String;
		public var expires:Number;
		public var path:String;
		public var value:String;
		
		public function GetCookiesData() {
			super();
		}
		
	}
}