package com.facebook.graph.data.api.checkin
{
	/**
	 * An object that defines a user in a check-in.
	 * @see http://developers.facebook.com/docs/reference/api/checkin
	 */
	public class FacebookCheckinTag
	{
		/**
		 * The tagged user's ID.
		 */
		public var id:String;
		
		/**
		 * The tagged user's full name.
		 */
		public var name:String;
		
		/**
		 * Creates a new FacebookCheckinTag.
		 */
		public function FacebookCheckinTag()
		{
		}
		
		/**
		 * Populates the tag from a decoded JSON object.
		 */
		public function fromJSON( result:Object ):void
		{
			if( result != null )
			{
				for( var property:String in result )
				{
					switch( property )
					{
						default:
							if( hasOwnProperty( property ) ) this[ property ] = result[ property ];
							break;
					}
				}
			}
		}
		
		/**
		 * Provides the string value of the tag.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}