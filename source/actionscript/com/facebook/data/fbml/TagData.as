package com.facebook.data.fbml {
	
	[Bindable]
	public class TagData {
		
		public var name:String;
		public var type:String;
		public var description:String;
		public var is_public:String;
		public var attributes:AttributeCollection;
		public var fbml:String;
		public var open_tag_fbml:String;
		public var close_tag_fbml:String;
		public var header_fbml:String;
		public var footer_fbml:String;
				
		public function TagData() {
			
		}

	}
}