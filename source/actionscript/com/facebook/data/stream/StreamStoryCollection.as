package com.facebook.data.stream {
	
	import com.facebook.utils.FacebookArrayCollection;
	
	[Bindable]
	public class StreamStoryCollection extends FacebookArrayCollection {
		
		public function StreamStoryCollection() {
			super(null, StreamStoryData);
		}
		
	}
}