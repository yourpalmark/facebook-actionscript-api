package com.facebook.graph.data.api.thread
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * A message thread in the new Facebook messaging system.
	 * @see http://developers.facebook.com/docs/reference/api/thread
	 */
	public class FacebookThread extends AbstractFacebookGraphObject
	{
		/**
		 * Fragment of the thread for use in thread lists.
		 */
		public var snippet:String;
		
		/**
		 * Timestamp of when the thread was last updated.
		 */
		public var updated_time:Date;
		
		/**
		 * Number of messages in the thread.
		 */
		public var message_count:int;
		
		/**
		 * Number of unread messages in the thread.
		 */
		public var unread_count:int;
		
		/**
		 * Thread tags.
		 */
		public var tags:Array;
		
		/**
		 * Creates a new FacebookThread.
		 */
		public function FacebookThread()
		{
		}
		
		/**
		 * Populates and returns a new FacebookThread from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookThread.
		 */
		public static function fromJSON( result:Object ):FacebookThread
		{
			var thread:FacebookThread = new FacebookThread();
			thread.fromJSON( result );
			return thread;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookThreadField.TAGS:
					tags = value is Array ? value : Object( value ).hasOwnProperty( "data" ) && value.data is Array ? value.data : [];
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
			return facebook_internal::toString( [ FacebookThreadField.ID, FacebookThreadField.SNIPPET ] );
		}
		
	}
}