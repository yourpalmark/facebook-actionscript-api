package com.facebook.graph.data.api.event
{
	import com.adobe.utils.DateUtil;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	/**
	 * Specifies information about an event, including the location, event name, and which invitees plan to attend.
	 * @see http://developers.facebook.com/docs/reference/api/event
	 */
	public class FacebookEvent
	{
		/**
		 * The event ID.
		 */
		public var id:String;
		
		/**
		 * An object containing the name and ID of the user who owns the event.
		 */
		public var owner:FacebookUser;
		
		/**
		 * The event title.
		 */
		public var name:String;
		
		/**
		 * The long-form HTML description of the event.
		 */
		public var description:String;
		
		/**
		 * The start time of the event, an ISO-8601 formatted date/time.
		 */
		public var start_time:Date;
		
		/**
		 * The end time of the event, an ISO-8601 formatted date/time.
		 */
		public var end_time:Date;
		
		/**
		 * The location for this event, a string name.
		 */
		public var location:String;
		
		/**
		 * The location of this event, a structured address object with the properties street, city, state, zip, country, latitude, and longitude.
		 */
		public var venue:Object;
		
		/**
		 * The visibility of this event.
		 * Can be 'OPEN', 'CLOSED', or 'SECRET'.
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
		 * Populates the event from a decoded JSON object.
		 */
		public function fromJSON( result:Object ):void
		{
			if( result != null )
			{
				for( var property:String in result )
				{
					switch( property )
					{
						case "owner":
							owner = new FacebookUser();
							owner.fromJSON( result[ property ] );
							break;
						
						case "start_time":
							start_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						case "end_time":
							end_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						case "updated_time":
							updated_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						default:
							if( hasOwnProperty( property ) ) this[ property ] = result[ property ];
							break;
					}
				}
			}
		}
		
		/**
		 * Provides the string value of the event.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}