package com.facebook.graph.data.api.subscription
{
	import com.adobe.utils.DateUtil;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	/**
	 * An individual subscription from an application to get real-time updates for an object type.
	 * @see http://developers.facebook.com/docs/reference/api/subscription
	 */
	public class FacebookSubscription
	{
		/**
		 * The object type.
		 * Currently user and permissions are supported.
		 */
		public var object:String;
		
		/**
		 * The list of fields for the object type.
		 */
		public var fields:Array;
		
		/**
		 * An endpoint on your domain which can handle the real-time notifications.
		 */
		public var callback_url:String;
		
		/**
		 * Whether or not the subscription is active or not.
		 */
		public var active:Boolean;
		
		/**
		 * Creates a new FacebookSubscription.
		 */
		public function FacebookSubscription()
		{
		}
		
		/**
		 * Populates the subscription from a decoded JSON object.
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
		 * Provides the string value of the subscription.
		 */
		public function toString():String
		{
			return '[ object: ' + object + ' ]';
		}
		
	}
}