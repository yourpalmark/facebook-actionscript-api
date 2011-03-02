package com.facebook.graph.data.api.photo
{
	import com.adobe.utils.DateUtil;
	
	/**
	 * An object that defines a user and their position in a photo.
	 * The x and y coordinates are percentages from the left and top edges of the photo, respectively.
	 * @see http://developers.facebook.com/docs/reference/api/photo
	 */
	public class FacebookPhotoTag
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
		 * The x position of the tag.
		 */
		public var x:Number;
		
		/**
		 * The y position of the tag.
		 */
		public var y:Number;
		
		/**
		 * The time the tag was initially created.
		 */
		public var created_time:Date;
		
		/**
		 * Creates a new FacebookPhotoTag.
		 */
		public function FacebookPhotoTag()
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
		 * Provides the string value of the tag.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ', x: ' + x + ', y: ' + y + ' ]';
		}
		
	}
}