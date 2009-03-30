package com.facebook.data.profile {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class InfoItemCollection extends FacebookArrayCollection {
		
		public function InfoItemCollection(source:Array=null) {
			super(null, InfoItemData);
		}
		
		public function addInfoItem(infoItemData:InfoItemData):void {
			this.addItem(infoItemData);
		}
		
	}
}