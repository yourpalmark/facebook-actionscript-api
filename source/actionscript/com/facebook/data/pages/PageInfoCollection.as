package com.facebook.data.pages {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class PageInfoCollection extends FacebookArrayCollection {
		
		public function PageInfoCollection() {
			super(null, PageInfoData);
		}
		
		public function addPageInfo(pageInfo:PageInfoData):void {
			this.addItem(pageInfo);
		}
		
	}
}