package com.facebook.data.photos {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetPhotosData extends FacebookData {
		
		public var photoCollection:PhotoCollection;
		
		public function GetPhotosData() {
			super();
		}
		
	}
}