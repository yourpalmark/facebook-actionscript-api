/*
This method hides a story your application published, removing it from the user's stream and proﬁle.
It doesn't delete the story.

*/
package com.facebook.commands.stream {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;

	public class RemovePost extends FacebookCall {
		
		public static const METHOD_NAME:String = 'stream.remove';
		public static const SCHEMA:Array = ['post_id'];
		
		public var post_id:String
		
		public function RemovePost(post_id:String) {
			super(METHOD_NAME);
			
			this.post_id = post_id;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, post_id);
			
			super.facebook_internal::initialize();
		}
		
	}
}