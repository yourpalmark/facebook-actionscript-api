package com.facebook.data.stream {
	
	import com.facebook.utils.FacebookArrayCollection;
	
	[Bindable]
	public class ProfileCollection extends FacebookArrayCollection {
		
		public function ProfileCollection() {
			super(null, ProfileData);
		}
		
	}
}