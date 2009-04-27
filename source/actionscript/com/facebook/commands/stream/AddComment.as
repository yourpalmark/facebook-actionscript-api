/*
This method adds a comment to a story already published in a user's stream.

*/
package com.facebook.commands.stream {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	public class AddComment extends FacebookCall {
		
		public static const METHOD_NAME:String = 'stream.addComment';
		public static const SCHEMA:Array = ['post_id', 'comment'];
		
		public var post_id:String
		public var comment:String
		
		public function AddComment(post_id:String, comment:String) {
			super(METHOD_NAME);
			
			this.post_id = post_id;
			this.comment = comment;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, post_id, comment);
			super.facebook_internal::initialize();
		}
		
	}
}