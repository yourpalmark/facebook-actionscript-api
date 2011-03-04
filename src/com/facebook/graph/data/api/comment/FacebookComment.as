package com.facebook.graph.data.api.comment
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	use namespace facebook_internal;
	
	/**
	 * A comment on a Graph API object.
	 * @see http://developers.facebook.com/docs/reference/api/comment
	 */
	public class FacebookComment extends AbstractFacebookGraphObject
	{
		/**
		 * The timedate the comment was created.
		 */
		public var created_time:Date;
		
		/**
		 * The comment text.
		 */
		public var message:String;
		
		/**
		 * The user that created the comment.
		 */
		public var from:FacebookUser;
		
		/**
		 * The number of times this comment was liked.
		 */
		public var likes:Number;
		
		/**
		 * Creates a new FacebookComment.
		 */
		public function FacebookComment()
		{
		}
		
		/**
		 * Populates and returns a new FacebookComment from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookComment.
		 */
		public static function fromJSON( result:Object ):FacebookComment
		{
			var comment:FacebookComment = new FacebookComment();
			comment.fromJSON( result );
			return comment;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookCommentField.FROM:
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
			return facebook_internal::toString( [ FacebookCommentField.ID, FacebookCommentField.MESSAGE ] );
		}
		
	}
}