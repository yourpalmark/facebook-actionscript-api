package com.facebook.graph.data.api.message
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	use namespace facebook_internal;
	
	/**
	 * An individual message in the new Facebook messaging system.
	 * @see http://developers.facebook.com/docs/reference/api/message
	 */
	public class FacebookMessage extends AbstractFacebookGraphObject
	{
		/**
		 * The sender of this message.
		 */
		public var from:FacebookUser;
		
		/**
		 * A list of the message recipients.
		 */
		public var to:Array;
		
		/**
		 * The text of the message.
		 */
		public var message:String;
		
		/**
		 * A timestamp of when this message was created.
		 */
		public var created_time:Date;
		
		/**
		 * Creates a new FacebookMessage.
		 */
		public function FacebookMessage()
		{
		}
		
		/**
		 * Populates and returns a new FacebookMessage from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookMessage.
		 */
		public static function fromJSON( result:Object ):FacebookMessage
		{
			var message:FacebookMessage = new FacebookMessage();
			message.fromJSON( result );
			return message;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookMessageField.FROM:
					from = FacebookUser.fromJSON( value );
					break;
				
				case FacebookMessageField.TO:
					to = [];
					var recipients:Array = value is Array ? value : Object( value ).hasOwnProperty( "data" ) && value.data is Array ? value.data : [];
					for each( var recipientData:Object in recipients )
					{
						to.push( FacebookUser.fromJSON( recipientData ) );
					}
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
			return facebook_internal::toString( [ FacebookMessageField.ID, FacebookMessageField.MESSAGE ] );
		}
		
	}
}