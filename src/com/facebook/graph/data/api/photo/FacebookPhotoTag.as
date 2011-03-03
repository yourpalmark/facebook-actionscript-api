package com.facebook.graph.data.api.photo
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.FacebookTag;
	
	use namespace facebook_internal;
	
	/**
	 * An object that defines a user and their position in a photo.
	 * The x and y coordinates are percentages from the left and top edges of the photo, respectively.
	 * @see http://developers.facebook.com/docs/reference/api/photo
	 */
	public class FacebookPhotoTag extends FacebookTag
	{
		/**
		 * The x position of the tag.
		 */
		public var x:Number;
		
		/**
		 * The y position of the tag.
		 */
		public var y:Number;
		
		/**
		 * The time the tag was initially created.
		 */
		public var created_time:Date;
		
		/**
		 * Creates a new FacebookPhotoTag.
		 */
		public function FacebookPhotoTag()
		{
		}
		
		/**
		 * Populates and returns a new FacebookPhotoTag from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookPhotoTag.
		 */
		public static function fromJSON( result:Object ):FacebookPhotoTag
		{
			var tag:FacebookPhotoTag = new FacebookPhotoTag();
			tag.fromJSON( result );
			return tag;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ "id", "name", "x", "y" ] );
		}
		
	}
}