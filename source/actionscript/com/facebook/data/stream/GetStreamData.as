package com.facebook.data.stream {
	
	import com.facebook.data.FacebookData;
	import com.facebook.data.photos.AlbumCollection;
	
	[Bindable]
	public class GetStreamData extends FacebookData  {
		
		public var stories:StreamStoryCollection;
		public var profiles:ProfileCollection;
		public var albums:AlbumCollection;
		
		public function GetStreamData() {
			super();
		}
		
	}
}