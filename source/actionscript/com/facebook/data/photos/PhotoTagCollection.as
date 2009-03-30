package com.facebook.data.photos {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class PhotoTagCollection extends FacebookArrayCollection {
		
		public function PhotoTagCollection(source:Array=null) {
			super(null, TagData);
		}
		
		public function addPhotoTag(tagData:TagData):void {
			this.addItem(tagData);
		}
		
	}
}