/*
This method returns all comments associated with a story.

*/
package com.facebook.commands.stream {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	public class GetComments extends FacebookCall {
		
		public static const METHOD_NAME:String = 'stream.getComments';
		public static const SCHEMA:Array = ['post_id'];
		
		public var post_id:String
		
		public function GetComments(post_id:String = null) {
			super(METHOD_NAME);
			
			this.post_id = post_id;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, post_id);
			super.facebook_internal::initialize();
		}
		
	}
}