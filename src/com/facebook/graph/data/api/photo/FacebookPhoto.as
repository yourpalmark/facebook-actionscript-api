package com.facebook.graph.data.api.photo
{
	import com.adobe.utils.DateUtil;
	
	/**
	 * An individual photo.
	 * @see http://developers.facebook.com/docs/reference/api/photo
	 */
	public class FacebookPhoto
	{
		/**
		 * The photo ID.
		 */
		public var id:String;
		
		/**
		 * An object containing the name and ID of the user who posted the photo.
		 * This may be a user or a Page.
		 */
		public var from:Object;
		
		/**
		 * An array containing the users and their positions in this photo.
		 * The x and y coordinates are percentages from the left and top edges of the photo, respectively.
		 */
		public var tags:Array;
		
		/**
		 * The caption given to this photo.
		 */
		public var name:String;
		
		/**
		 * The album-sized view of the photo.
		 */
		public var picture:String;
		
		/**
		 * The icon that Facebook displays when photos are published to the Feed.
		 */
		public var icon:String;
		
		/**
		 * The full-sized source of the photo.
		 */
		public var source:String;
		
		/**
		 * The height of the photo, in pixels.
		 */
		public var height:int;
		
		/**
		 * The width of the photo, in pixels.
		 */
		public var width:int;
		
		/**
		 * A link to the photo on Facebook.
		 */
		public var link:String;
		
		/**
		 * The time the photo was initially published.
		 */
		public var created_time:Date;
		
		/**
		 * The last time the photo or its caption were updated.
		 */
		public var updated_time:Date;
		
		/**
		 * Creates a new FacebookPhoto.
		 */
		public function FacebookPhoto()
		{
		}
		
		/**
		 * Populates the photo from a decoded JSON object.
		 */
		public function fromJSON( result:Object ):void
		{
			if( result != null )
			{
				for( var property:String in result )
				{
					switch( property )
					{
						case "created_time":
							created_time = DateUtil.parseW3CDTF( result[ property ] );
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
		 * Provides the string value of the photo.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}