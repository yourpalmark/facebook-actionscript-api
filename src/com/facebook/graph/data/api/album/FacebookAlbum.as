package com.facebook.graph.data.api.album
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * A photo album.
	 * @see http://developers.facebook.com/docs/reference/api/album
	 */
	public class FacebookAlbum extends AbstractFacebookGraphObject
	{
		/**
		 * The profile that created this album.
		 */
		public var from:Object;
		
		/**
		 * The title of the album.
		 */
		public var name:String;
		
		/**
		 * The description of the album.
		 */
		public var description:String;
		
		/**
		 * The location of the album.
		 */
		public var location:String;
		
		/**
		 * A link to this album on Facebook.
		 */
		public var link:String;
		
		/**
		 * The privacy settings for the album.
		 */
		public var privacy:String;
		
		/**
		 * The number of photos in this album.
		 */
		public var count:int;
		
		/**
		 * The time the photo album was initially created.
		 */
		public var created_time:Date;
		
		/**
		 * The last time the photo album was updated.
		 */
		public var updated_time:Date;
		
		/**
		 * The type of photo album.
		 */
		public var type:String;
		
		/**
		 * Creates a new Album.
		 */
		public function FacebookAlbum()
		{
		}
		
		/**
		 * Populates and returns a new FacebookAlbum from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookAlbum.
		 */
		public static function fromJSON( result:Object ):FacebookAlbum
		{
			var album:FacebookAlbum = new FacebookAlbum();
			album.fromJSON( result );
			return album;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ FacebookAlbumField.ID, FacebookAlbumField.NAME ] );
		}
		
	}
}