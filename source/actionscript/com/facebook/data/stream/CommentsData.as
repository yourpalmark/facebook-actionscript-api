package com.facebook.data.stream {
	
	[Bindable]
	public class CommentsData {
		
		public var can_post:Boolean;
		public var can_remove:Boolean;
		public var count:uint;
		public var posts:Array;
		
		public function CommentsData() {
			
		}

	}
}