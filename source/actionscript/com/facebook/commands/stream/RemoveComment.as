/*
This method removes a comment from a story.

*/
package com.facebook.commands.stream {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	public class RemoveComment extends FacebookCall {
		
		public static const METHOD_NAME:String = 'stream.removeComment';
		public static const SCHEMA:Array = ['comment_id','uid'];
		
		public var comment_id:String;
		public var uid:String;
		
		public function RemoveComment(comment_id:String, uid:String = null) {
			super(METHOD_NAME);
			
			this.comment_id = comment_id;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, comment_id, uid);
			super.facebook_internal::initialize();
		}
		
	}
}