package com.facebook.graph.data.api.link
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	use namespace facebook_internal;
	
	/**
	 * A link shared on a user's wall.
	 * @see http://developers.facebook.com/docs/reference/api/link
	 */
	public class FacebookLink extends AbstractFacebookGraphObject
	{
		/**
		 * The user that created the link.
		 */
		public var from:FacebookUser;
		
		/**
		 * The URL that was shared.
		 */
		public var link:String;
		
		/**
		 * The name of the link.
		 */
		public var name:String;
		
		/**
		 * The caption of the link (appears beneath the link name).
		 */
		public var caption:String;
		
		/**
		 * A description of the link (appears beneath the link caption).
		 */
		public var description:String;
		
		/**
		 * A URL to the link icon that Facebook displays in the news feed.
		 */
		public var icon:String;
		
		/**
		 * A URL to the thumbnail image used in the link post.
		 */
		public var picture:String;
		
		/**
		 * The optional message from the user about this link.
		 */
		public var message:String;
		
		/**
		 * The time the link was published.
		 */
		public var created_time:Date;
		
		/**
		 * Creates a new FacebookLink.
		 */
		public function FacebookLink()
		{
		}
		
		/**
		 * Populates and returns a new FacebookLink from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookLink.
		 */
		public static function fromJSON( result:Object ):FacebookLink
		{
			var link:FacebookLink = new FacebookLink();
			link.fromJSON( result );
			return link;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookLinkField.FROM:
					from = FacebookUser.fromJSON( value );
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
			return facebook_internal::toString( [ FacebookLinkField.ID, FacebookLinkField.NAME ] );
		}
		
	}
}