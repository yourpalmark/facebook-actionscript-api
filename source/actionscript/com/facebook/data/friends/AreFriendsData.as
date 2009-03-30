package com.facebook.data.friends {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class AreFriendsData extends FacebookData {
		
		public var friendsCollection:FriendsCollection;
		
		public function AreFriendsData() {
			super();
		}
		
	}
}