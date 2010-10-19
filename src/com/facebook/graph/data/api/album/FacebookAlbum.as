package com.facebook.graph.data.api.album
{
	import com.adobe.utils.DateUtil;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	/**
	 * A photo album.
	 * @see http://developers.facebook.com/docs/reference/api/album
	 */
	public class FacebookAlbum
	{
		/**
		 * The photo album ID.
		 */
		public var id:String;
		
		/**
		 * An object containing the ID and name of the profile who posted this album.
		 */
		public var from:FacebookUser;
		
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
		 * Comments on the album.
		 */
		public var comments:Object;
		
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
		 * Populates the album from a decoded JSON object.
		 */
		public function fromJSON( result:Object ):void
		{
			if( result != null )
			{
				for( var property:String in result )
				{
					switch( property )
					{
						case "from":
							from = new FacebookUser();
							from.fromJSON( result[ property ] );
							break;
						
						case "created_time":
							created_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						case "updated_time":
							updated_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						default:
							if( hasOwnProperty( property ) ) this[ property ] = result[ property ];
							break;
					}
				}
			}
		}
		
		/**
		 * Provides the string value of the album.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}