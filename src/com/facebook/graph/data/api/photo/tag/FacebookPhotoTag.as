package com.facebook.graph.data.api.photo.tag
{
	import com.adobe.utils.DateUtil;

	public class FacebookPhotoTag
	{
		public var id:String;
		
		public var name:String;
		
		public var x:Number;
		
		public var y:Number;
		
		public var created_time:Date;
		
		/**
		 * Creates a new FacebookPhotoTag.
		 */
		public function FacebookPhotoTag()
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
						
						if( hasOwnProperty( property ) ) this[ property ] = result[ property ];
							break;
					}
				}
			}
		}
	}
}