package com.facebook.graph.data.api.status
{
	import com.adobe.utils.DateUtil;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	/**
	 * A status message on a user's wall.
	 * @see http://developers.facebook.com/docs/reference/api/status
	 */
	public class FacebookStatusMessage
	{
		/**
		 * The status message ID.
		 */
		public var id:String;
		
		/**
		 * An object containing the name and ID of the user who posted the message.
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
		 * Populates the status from a decoded JSON object.
		 */
		public function fromJSON( result:Object ):void
		{
			if( result != null )
			{
				for( var property:String in result )
				{
					switch( property )
					{
						case "from":
							from = new FacebookUser();
							from.fromJSON( result[ property ] );
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
		 * Provides the string value of the status.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', message: ' + message + ' ]';
		}
		
	}
}