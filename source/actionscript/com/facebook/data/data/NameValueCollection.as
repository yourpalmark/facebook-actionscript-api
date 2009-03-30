package com.facebook.data.data {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class NameValueCollection extends FacebookArrayCollection {
		
		public function NameValueCollection() {
			super(null, NameValueData);
		}
		
	}
}