package com.facebook.graph.data.api.core
{
	import com.facebook.graph.core.facebook_internal;
	
	use namespace facebook_internal;
	
	/**
	 * An object that defines a tagged user.
	 */
	public class FacebookTag extends AbstractFacebookGraphObject
	{
		/**
		 * The tagged user's full name.
		 */
		public var name:String;
		
		/**
		 * Creates a new FacebookTag.
		 */
		public function FacebookTag()
		{
		}
		
		/**
		 * Populates and returns a new FacebookTag from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookTag.
		 */
		public static function fromJSON( result:Object ):FacebookTag
		{
			var tag:FacebookTag = new FacebookTag();
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