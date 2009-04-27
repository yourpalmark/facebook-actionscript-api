package com.facebook.data.stream {
	
	[Bindable]
	public class AttachmentData {
		
		public var icon:String;
		public var title:String;
		public var label:String;
		public var text:String;
		public var body:String;
		public var media:Array; //Array Of StreamMediaData
		public var href:String;
		public var caption:String;
		
		public function AttachmentData() {
			
		}

	}
}