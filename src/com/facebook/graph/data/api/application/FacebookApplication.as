package com.facebook.graph.data.api.application
{
	/**
	 * An individual application registered on the Facebook Platform.
	 * @see http://developers.facebook.com/docs/reference/api/application
	 */
	public class FacebookApplication
	{
		/**
		 * The application ID.
		 */
		public var id:String;
		
		/**
		 * The title of the application.
		 */
		public var name:String;
		
		/**
		 * The description of the application written by the 3rd party developers.
		 */
		public var description:String;
		
		/**
		 * The category of the application.
		 */
		public var category:String;
		
		/**
		 * A link to the application dashboard on Facebook.
		 */
		public var link:String;
		
		/**
		 * Creates a new FacebookApplication.
		 */
		public function FacebookApplication()
		{
		}
		
		/**
		 * Populates the application from a decoded JSON object.
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
		 * Provides the string value of the application.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}