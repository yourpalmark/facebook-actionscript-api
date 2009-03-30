package com.facebook.data.photos {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetAlbumsData extends FacebookData {
		
		public var albumCollection:AlbumCollection;
		
		public function GetAlbumsData() {
			super();
		}
		
	}
}