package com.facebook.data.fbml {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class TagCollection extends FacebookArrayCollection {
		
		public function TagCollection() {
			super(null, AbstractTagData);
		}
		
	}
}