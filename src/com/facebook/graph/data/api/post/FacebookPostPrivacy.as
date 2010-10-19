package com.facebook.graph.data.api.post
{
	/**
	 * An object that defines the privacy setting for a post, video, or album.
	 * @see http://developers.facebook.com/docs/reference/api/post
	 */	
	public class FacebookPostPrivacy
	{
		/**
		 * The privacy value description.
		 */
		public var description:String;
		
		/**
		 * The privacy value for the object, specify one of EVERYONE, CUSTOM, ALL_FRIENDS, NETWORKS_FRIENDS, FRIENDS_OF_FRIENDS.
		 */
		public var value:String;
		
		/**
		 * For CUSTOM settings, this indicates which users can see the object.
		 * Can be one of EVERYONE, NETWORKS_FRIENDS (when the object can be seen by networks and friends), FRIENDS_OF_FRIENDS, ALL_FRIENDS, SOME_FRIENDS, SELF, or NO_FRIENDS (when the object can be seen by a network only).
		 */
		public var friends:String;
		
		/**
		 * For CUSTOM settings, specify a comma-separated list of network IDs that can see the object, or 1 for all of a user's networks.
		 */
		public var networks:Array;
		
		/**
		 * When friends is set to SOME_FRIENDS, specify a comma-separated list of user IDs and friend list IDs that "can" see the post.
		 */
		public var allow:Array;
		
		/**
		 * When friends is set to SOME_FRIENDS, specify a comma-separated list of user IDs and friend list IDs that "cannot" see the post.
		 */
		public var deny:Array;
		
		/**
		 * Creates a new FacebookPostPrivacy.
		 */
		public function FacebookPostPrivacy()
		{
		}
		
		/**
		 * Populates the post from a decoded JSON object.
		 */
		public function fromJSON( result:Object ):void
		{
			if( result != null )
			{
				for( var property:String in result )
				{
					switch( property )
					{
						default:
							if( hasOwnProperty( property ) ) this[ property ] = result[ property ];
							break;
					}
				}
			}
		}
		
	}
}