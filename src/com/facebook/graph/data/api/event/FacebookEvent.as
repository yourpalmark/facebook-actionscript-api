package com.facebook.graph.data.api.event
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	import com.facebook.graph.data.api.core.FacebookLocation;
	
	use namespace facebook_internal;
	
	/**
	 * Specifies information about an event, including the location, event name, and which invitees plan to attend.
	 * @see http://developers.facebook.com/docs/reference/api/event
	 */
	public class FacebookEvent extends AbstractFacebookGraphObject
	{
		/**
		 * The profile that created the event.
		 */
		public var owner:Object;
		
		/**
		 * The event title.
		 */
		public var name:String;
		
		/**
		 * The long-form description of the event.
		 */
		public var description:String;
		
		/**
		 * The start time of the event, as you want it to be displayed on facebook.
		 */
		public var start_time:Date;
		
		/**
		 * The end time of the event, as you want it to be displayed on facebook.
		 */
		public var end_time:Date;
		
		/**
		 * The location for this event.
		 */
		public var location:String;
		
		/**
		 * The location of this event.
		 */
		public var venue:FacebookLocation;
		
		/**
		 * The visibility of this event.
		 */
		public var privacy:String;
		
		/**
		 * The last time the event was updated.
		 */
		public var updated_time:Date;
		
		/**
		 * Creates a new FacebookEvent.
		 */
		public function FacebookEvent()
		{
		}
		
		/**
		 * Populates and returns a new FacebookEvent from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookEvent.
		 */
		public static function fromJSON( result:Object ):FacebookEvent
		{
			var event:FacebookEvent = new FacebookEvent();
			event.fromJSON( result );
			return event;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookEventField.VENUE:
					venue = FacebookLocation.fromJSON( value );
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
			return facebook_internal::toString( [ FacebookEventField.ID, FacebookEventField.NAME ] );
		}
		
	}
}