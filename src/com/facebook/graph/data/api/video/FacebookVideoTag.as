package com.facebook.graph.data.api.video
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.FacebookTag;
	
	use namespace facebook_internal;
	
	/**
	 * An object that defines a user in a video.
	 * @see http://developers.facebook.com/docs/reference/api/video
	 */
	public class FacebookVideoTag extends FacebookTag
	{
		/**
		 * The time the tag was initially created.
		 */
		public var created_time:Date;
		
		/**
		 * Creates a new FacebookVideoTag.
		 */
		public function FacebookVideoTag()
		{
		}
		
		/**
		 * Populates and returns a new FacebookVideoTag from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookVideoTag.
		 */
		public static function fromJSON( result:Object ):FacebookVideoTag
		{
			var tag:FacebookVideoTag = new FacebookVideoTag();
			tag.fromJSON( result );
			return tag;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ "id", "name" ] );
		}
		
	}
}