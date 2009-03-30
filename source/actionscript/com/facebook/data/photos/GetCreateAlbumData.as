package com.facebook.data.photos {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetCreateAlbumData extends FacebookData {
		
		public var albumData:AlbumData;
		
		public function GetCreateAlbumData() {
			super();
		}
		
	}
}