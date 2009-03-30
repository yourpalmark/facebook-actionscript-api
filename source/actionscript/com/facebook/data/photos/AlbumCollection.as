package com.facebook.data.photos {
	
	import com.facebook.utils.FacebookArrayCollection;
	
	[Bindable]
	public class AlbumCollection extends FacebookArrayCollection {
		
		public function AlbumCollection() {
			super(null, AlbumData);			
		}
		
		public function addAlbum(albumData:AlbumData):void {
			this.addItem(albumData);
		}
		
	}
}