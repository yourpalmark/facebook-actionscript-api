package com.facebook.graph.data.api.page
{
	import com.adobe.utils.DateUtil;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	/**
	 * A Facebook page.
	 * @see http://developers.facebook.com/docs/reference/api/page
	 */
	public class FacebookPage
	{
		/**
		 * The page's ID.
		 */
		public var id:String;
		
		/**
		 * The page's name.
		 */
		public var name:String;
		
		/**
		 * The pages profile picture.
		 */
		public var picture:String;
		
		/**
		 * The page's category.
		 */
		public var category:String;
		
		/**
		 * The number of fans the page has.
		 */
		public var fan_count:int;
		
		/**
		 * Creates a new FacebookPage.
		 */
		public function FacebookPage()
		{
		}
		
		/**
		 * Populates the page from a decoded JSON object.
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
		 * Provides the string value of the page.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}