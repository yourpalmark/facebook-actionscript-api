package com.facebook.data.events {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class FacebookEventDataCollection extends FacebookArrayCollection {
		
		public function FacebookEventDataCollection() {
			super(null, FacebookEventData);
		}
		
	}
}