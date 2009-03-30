package com.facebook.data.fbml {
	
	import com.facebook.utils.FacebookArrayCollection;
	
	[Bindable]
	public class AttributeCollection extends FacebookArrayCollection {
		
		public function AttributeCollection() {
			super(null, AttributeData);
		}
		
	}
}