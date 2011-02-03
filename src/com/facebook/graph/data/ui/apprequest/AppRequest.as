package com.facebook.graph.data.ui.apprequest
{
	public class AppRequest
	{
		/**
		 * The message the receiving user will see.
		 * It appears as a question posed by the sending user.
		 * The maximum length is 255 characters.
		 */
		public var message:String;
		
		/**
		 * A comma-separated list containing user IDs or usernames.
		 * If this is specified, the user will not have a choice of recipients.
		 * If this is omitted, the user will see a friend selector.
		 */
		public var to:Array; //Array of user IDs or usernames
		
		/**
		 * Optional. This controls what sets of friends get shown if a friend selector is shown.
		 * The different sets are selectable in a selector.
		 * The value is a list of filters for friends to show.
		 * Filters are selectable by the user using a selector in the dialog.
		 * A built-in filter is expressed as a string 'all', 'app_users', or 'app_non_users'.
		 * Respectively, these denote all friends, friends who use the application, and friends who don't.
		 * Custom filters are expressed as dictionaries with a 'name' key and a 'user_ids' key, which respectively have values that are a string and a list of user ids.
		 * 'name' is the name of the custom filter that will show in the selector.
		 * 'user_ids' is the list of friends to include, in the order in which they are to appear.
		 * Default value is '', which has the same effect as ['all', 'app_users', 'app_non_users'].
		 */
		public var filters:Array; //Array of filter strings or dictionaries.
		
		/**
		 * Optional. 255 character string of data that you can add for bookkeeping purposes.
		 * You can read this back as part of the request object.
		 */
		public var app_data:String;
		
		/**
		 * Optional. The title for the friend selector dialog.
		 * Maximum length is 50 characters.
		 */
		public var title:String;
		
		public function AppRequest()
		{
		}
		
		public function toObject():Object
		{
			var object:Object = {};
			if( message ) object.message = message;
			if( to && to.length > 0 ) object.to = to.join( "," );
			if( filters && filters.length > 0 )
			{
				object.filters = [];
				for each( var filter:* in filters )
				{
					object.filters.push( filter );
				}
			}
			if( app_data ) object.app_data = app_data;
			if( title ) object.title = title;
			return object;
		}
		
	}
}