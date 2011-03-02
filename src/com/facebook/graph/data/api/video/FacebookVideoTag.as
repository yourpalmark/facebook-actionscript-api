package com.facebook.graph.data.api.video
{
	import com.adobe.utils.DateUtil;
	
	/**
	 * An object that defines a user in a video.
	 * @see http://developers.facebook.com/docs/reference/api/video
	 */
	public class FacebookVideoTag
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
		 * The time the tag was initially created.
		 */
		public var created_time:Date;
		
		/**
		 * Creates a new FacebookVideoTag.
		 */
		public function FacebookVideoTag()
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
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}