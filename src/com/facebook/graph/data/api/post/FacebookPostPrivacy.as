package com.facebook.graph.data.api.post
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * An object that defines the privacy setting of a post.
	 * @see http://developers.facebook.com/docs/reference/api/post
	 */	
	public class FacebookPostPrivacy extends AbstractFacebookGraphObject
	{
		/**
		 * The value field may specify one of the following JSON strings: EVERYONE, CUSTOM, ALL_FRIENDS, NETWORKS_FRIENDS, FRIENDS_OF_FRIENDS.
		 */
		public var value:String;
		
		/**
		 * The friends field must be specified if value is set to CUSTOM and contain one of the following JSON strings:
		 * EVERYONE, NETWORKS_FRIENDS (when the object can be seen by networks and friends), FRIENDS_OF_FRIENDS, ALL_FRIENDS, SOME_FRIENDS, SELF, or NO_FRIENDS (when the object can be seen by a network only).
		 */
		public var friends:String;
		
		/**
		 * The networks field may contain a comma-separated list of network IDs that can see the object, or 1 for all of a user's network.
		 */
		public var networks:Array;
		
		/**
		 * The allow field must be specified when the friends value is set to SOME_FRIENDS and must specify a comma-separated list of user IDs and friend list IDs that 'can' see the post.
		 */
		public var allow:Array;
		
		/**
		 * The deny field may be specified if the friends field is set to SOME_FRIENDS and must specify a comma-separated list of user IDs and friend list IDs that 'cannot' see the post.
		 */
		public var deny:Array;
		
		/**
		 * The privacy value description.
		 */
		public var description:String;
		
		/**
		 * Creates a new FacebookPostPrivacy.
		 */
		public function FacebookPostPrivacy()
		{
		}
		
		/**
		 * Populates and returns a new FacebookPostPrivacy from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookPostPrivacy.
		 */
		public static function fromJSON( result:Object ):FacebookPostPrivacy
		{
			var privacy:FacebookPostPrivacy = new FacebookPostPrivacy();
			privacy.fromJSON( result );
			return privacy;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case "networks":
				case "allow":
				case "deny":
					this[ property ] = value is Array ? value : value is String ? String( value ).split( "," ) : [ value ];
					break;
				
				default:
					super.setPropertyValue( property, value );
					break;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ "value" ] );
		}
		
	}
}