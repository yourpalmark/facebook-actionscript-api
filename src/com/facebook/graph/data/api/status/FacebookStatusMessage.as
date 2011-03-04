package com.facebook.graph.data.api.status
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	use namespace facebook_internal;
	
	/**
	 * A status message on a user's wall.
	 * @see http://developers.facebook.com/docs/reference/api/status
	 */
	public class FacebookStatusMessage extends AbstractFacebookGraphObject
	{
		/**
		 * The user who posted the message.
		 */
		public var from:FacebookUser;
		
		/**
		 * The status message content.
		 */
		public var message:String;
		
		/**
		 * The time the message was published.
		 */
		public var updated_time:Date;
		
		/**
		 * Creates a new FacebookStatusMessage.
		 */
		public function FacebookStatusMessage()
		{
		}
		
		/**
		 * Populates and returns a new FacebookStatusMessage from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookStatusMessage.
		 */
		public static function fromJSON( result:Object ):FacebookStatusMessage
		{
			var status:FacebookStatusMessage = new FacebookStatusMessage();
			status.fromJSON( result );
			return status;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookStatusMessageField.FROM:
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
			return facebook_internal::toString( [ FacebookStatusMessageField.ID, FacebookStatusMessageField.MESSAGE ] );
		}
		
	}
}