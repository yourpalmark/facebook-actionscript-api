package com.facebook.streamdemo.data {
	
	import com.facebook.data.users.FacebookUser;
	
	public class StreamData {
		
		public static var STORY:String = 'story';
		//public static var PHOTO:String = 'photo'; //Not implemented
		
		public var time:Date;
		public var type:String; //Will currently always be story.
		public var facebookType:uint;
		public var title:String;
		public var message:String;
		public var friend:FacebookUser;
		public var likeCount:Number;
		public var data:Object;
		
		public function StreamData(type:String) {
			this.type = type;
		}
	}
}