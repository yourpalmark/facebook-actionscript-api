package com.facebook.graph.data.ui.stream
{
	public class StreamPrivacy
	{
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
		
		public function StreamPrivacy()
		{
		}
		
		public function toObject():Object
		{
			var object:Object = {};
			object.value = value;
			if( friends ) object.friends = friends;
			if( networks && networks.length > 0 )
			{
				object.networks = networks.join( "," );
			}
			if( allow && allow.length > 0 )
			{
				object.allow = allow.join( "," );
			}
			if( deny && deny.length > 0 )
			{
				object.deny = deny.join( "," );
			}
			return object;
		}
		
	}
}