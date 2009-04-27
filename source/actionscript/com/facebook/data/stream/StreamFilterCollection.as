package com.facebook.data.stream {
	
	import com.facebook.utils.FacebookArrayCollection;
	
	[Bindable]
	public class StreamFilterCollection extends FacebookArrayCollection {
		
		public function StreamFilterCollection() {
			super(null, StreamFilterData);
		}
		
	}
}