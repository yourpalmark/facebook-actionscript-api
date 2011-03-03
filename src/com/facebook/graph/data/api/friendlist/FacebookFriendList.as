package com.facebook.graph.data.api.friendlist
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * A Facebook friend list.
	 * @see http://developers.facebook.com/docs/reference/api/friendlist
	 */
	public class FacebookFriendList extends AbstractFacebookGraphObject
	{
		/**
		 * The name of the friend list.
		 */
		public var name:String;
		
		/**
		 * Creates a new FacebookFriendList.
		 */
		public function FacebookFriendList()
		{
		}
		
		/**
		 * Populates and returns a new FacebookFriendList from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookFriendList.
		 */
		public static function fromJSON( result:Object ):FacebookFriendList
		{
			var friendlist:FacebookFriendList = new FacebookFriendList();
			friendlist.fromJSON( result );
			return friendlist;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ FacebookFriendListField.ID, FacebookFriendListField.NAME ] );
		}
		
	}
}