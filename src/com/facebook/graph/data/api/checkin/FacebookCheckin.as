package com.facebook.graph.data.api.checkin
{
	import com.adobe.utils.DateUtil;
	import com.facebook.graph.data.api.application.FacebookApplication;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	/**
	 * A check-in that was made through Facebook Places.
	 * @see http://developers.facebook.com/docs/reference/api/checkin
	 */
	public class FacebookCheckin
	{
		/**
		 * The check-in ID.
		 */
		public var id:String;
		
		/**
		 * The ID and name of the user who made the check-in.
		 */
		public var from:FacebookUser;
		
		/**
		 * The users the author tagged in the check-in.
		 */
		public var tags:Object;
		
		/**
		 * The ID, name, and location of the Facebook Page that represents the location of the check-in.
		 */
		public var place:Object;
		
		/**
		 * The message the user added to the check-in.
		 */
		public var message:String;
		
		/**
		 * The latitude and longitude of the check-in location.
		 */
		public var coordinates:String;
		
		/**
		 * The ID and name of the application that made the check-in.
		 */
		public var application:FacebookApplication;
		
		/**
		 * The time the check-in was created.
		 */
		public var created_time:Date;
		
		/**
		 * Creates a new FacebookCheckin.
		 */
		public function FacebookCheckin()
		{
		}
		
		/**
		 * Populates the checkin from a decoded JSON object.
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
						
						case "application":
							application = new FacebookApplication();
							application.fromJSON( result[ property ] );
							break;
						
						case "created_time":
							created_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						default:
							if( hasOwnProperty( property ) ) this[ property ] = result[ property ];
							break;
					}
				}
			}
		}
		
		/**
		 * Provides the string value of the checkin.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ' ]';
		}
		
	}
}