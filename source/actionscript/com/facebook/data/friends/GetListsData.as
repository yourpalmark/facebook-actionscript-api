package com.facebook.data.friends {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetListsData extends FacebookData {
		
		public var friendsListCollection:FriendsCollection;
		
		public function GetListsData() {
			super();
		}
		
	}
}