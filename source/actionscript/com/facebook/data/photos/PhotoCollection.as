package com.facebook.data.photos {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class PhotoCollection extends FacebookArrayCollection {
		
		public function PhotoCollection() {
			super(null, PhotoData);
		}
		
		public function addPhoto(photoData:PhotoData):void {
			this.addItem(photoData);
		}
		
	}
}