package com.facebook.graph.data.api.post
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	use namespace facebook_internal;
	
	/**
	 * An individual entry in a profile's feed.
	 * @see http://developers.facebook.com/docs/reference/api/post
	 */
	public class FacebookPost extends AbstractFacebookGraphObject
	{
		/**
		 * The number of likes on this post.
		 */
		public var likes:Number;
		
		/**
		 * Information about the user who posted the message.
		 */
		public var from:FacebookUser;
		
		/**
		 * Profiles mentioned or targeted in this post.
		 */
		public var to:Object;
		
		/**
		 * The message.
		 */
		public var message:String;
		
		/**
		 * If available, a link to the picture included with this post.
		 */
		public var picture:String;
		
		/**
		 * The link attached to this post.
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
		 * A URL to a Flash movie or video file to be embedded within the post.
		 */
		public var source:String;
		
		/**
		 * A link to an icon representing the type of this post.
		 */
		public var icon:String;
		
		/**
		 * A string indicating which application was used to create this post.
		 */
		public var attribution:String;
		
		/**
		 * A list of available actions on the post (including commenting, liking, and an optional app-specified action).
		 */
		public var actions:Array;
		
		/**
		 * The privacy settings of the Post.
		 */
		public var privacy:FacebookPostPrivacy;
		
		/**
		 * The time the post was initially published.
		 */
		public var created_time:Date;
		
		/**
		 * The time of the last comment on this post.
		 */
		public var updated_time:Date;
		
		/**
		 * Location and language restrictions for Page posts only.
		 */
		public var targeting:Object;
		
		/**
		 * The type of this post.
		 */
		public var type:String;
		
		/**
		 * Creates a new FacebookPost.
		 */
		public function FacebookPost()
		{
		}
		
		/**
		 * Populates and returns a new FacebookPost from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookPost.
		 */
		public static function fromJSON( result:Object ):FacebookPost
		{
			var post:FacebookPost = new FacebookPost();
			post.fromJSON( result );
			return post;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookPostField.FROM:
					from = FacebookUser.fromJSON( value );
					break;
				
				case FacebookPostField.PRIVACY:
					privacy = FacebookPostPrivacy.fromJSON( value );
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
			return facebook_internal::toString( [ FacebookPostField.ID, FacebookPostField.NAME ] );
		}
		
	}
}