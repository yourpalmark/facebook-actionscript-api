package com.facebook.data.friends {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class FriendsCollection extends FacebookArrayCollection {
		
		public function FriendsCollection() {
			super(null, FriendsData);
		}
		
	}
}