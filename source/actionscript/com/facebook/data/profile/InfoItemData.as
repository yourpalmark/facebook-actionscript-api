package com.facebook.data.profile {
	
	import com.facebook.facebook_internal;
	
	[Bindable]
	public class InfoItemData {
		
		public var label:String;
		public var sublabel:String;
		public var description:String;
		public var link:String;
		public var image:String;
		
		facebook_internal var schema:Array;
		
		public function InfoItemData() {
			facebook_internal::schema = ['label', 'link', 'image', 'description', 'sublabel'];
		}

	}
}