package com.facebook.data.stream {
	
	import com.facebook.data.users.FacebookUserCollection;
	import com.facebook.data.users.UserCollection;	
	
	[Bindable]
	public class LikesData {
		
		public var href:String;
		public var count:uint;
		public var user_likes:Boolean;
		public var can_like:Boolean;
		
		public var friends:Array;  //of uids
		public var sample:Array; //of uids
		
		public function LikesData() {
			
		}

	}
}