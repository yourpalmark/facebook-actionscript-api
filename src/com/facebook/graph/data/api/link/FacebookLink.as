package com.facebook.graph.data.api.link
{
	import com.adobe.utils.DateUtil;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	/**
	 * A link shared on a user's wall.
	 * @see http://developers.facebook.com/docs/reference/api/link
	 */
	public class FacebookLink
	{
		/**
		 * The link ID.
		 */
		public var id:String;
		
		/**
		 * An object containing the name and ID of the user who posted the link.
		 */
		public var from:FacebookUser;
		
		/**
		 * The actual URL that was shared.
		 */
		public var link:String;
		
		/**
		 * The name of the link.
		 */
		public var name:String;
		
		/**
		 * The caption of the link (appears beneath the link name).
		 */
		public var caption:String;
		
		/**
		 * A description of the link (appears beneath the link caption).
		 */
		public var description:String;
		
		/**
		 * The link icon that Facebook displays.
		 */
		public var icon:String;
		
		/**
		 * A picture to use as the thumbnail in the link post.
		 */
		public var picture:String;
		
		/**
		 * The optional message from the user about this link.
		 */
		public var message:String;
		
		/**
		 * The time the link was published.
		 */
		public var created_time:Date;
		
		/**
		 * Creates a new FacebookLink.
		 */
		public function FacebookLink()
		{
		}
		
		/**
		 * Populates the link from a decoded JSON object.
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
		 * Provides the string value of the link.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}