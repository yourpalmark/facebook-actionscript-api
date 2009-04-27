package com.facebook.data.stream {
	
	[Bindable]
	public class StreamStoryData {
		
		public var post_id:String;
		public var viewer_id:String;
		public var source_id:String;
		public var type:uint;
		public var actor_id:String;
		public var message:String;
		
		public var app_id:String;
		public var attribution:String;
		
		public var attachment:AttachmentData;
		public var metadata:Object;
		public var likes:LikesData;
		public var updated_time:Date;
		public var created_time:Date;
		public var comments:CommentsData;
		
		public var privacy:String;
		public var filter_key:String;
		
		public var sourceXML:XML;
		
		public function StreamStoryData() {
			
		}

	}
}