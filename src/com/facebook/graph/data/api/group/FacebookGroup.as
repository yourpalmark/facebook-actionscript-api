package com.facebook.graph.data.api.group
{
	import com.adobe.utils.DateUtil;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	/**
	 * A Facebook group.
	 * @see http://developers.facebook.com/docs/reference/api/group
	 */
	public class FacebookGroup
	{
		/**
		 * The group ID.
		 */
		public var id:String;
		
		/**
		 * An object containing the name and ID of the user who owns the group.
		 */
		public var owner:FacebookUser;
		
		/**
		 * The group title.
		 */
		public var name:String;
		
		/**
		 * The group description.
		 */
		public var description:String;
		
		/**
		 * The URL for the group's website.
		 */
		public var link:String;
		
		/**
		 * The location of this group, a structured address object with the properties street, city, state, zip, country, latitude, and longitude.
		 */
		public var venue:Object;
		
		/**
		 * The privacy setting of the group, either 'OPEN', 'CLOSED', or 'SECRET'.
		 */
		public var privacy:String;
		
		/**
		 * The last time the group was updated.
		 */
		public var updated_time:Date;
		
		/**
		 * Creates a new FacebookGroup.
		 */
		public function FacebookGroup()
		{
		}
		
		/**
		 * Populates the group from a decoded JSON object.
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
		 * Provides the string value of the group.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}