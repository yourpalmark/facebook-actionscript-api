package com.facebook.graph.data.api.subscription
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * A subscription to an application to get real-time updates for an Graph object type.
	 * @see http://developers.facebook.com/docs/reference/api/subscription
	 */
	public class FacebookSubscription extends AbstractFacebookGraphObject
	{
		/**
		 * The object type to subscribe to.
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
		 * Populates and returns a new FacebookSubscription from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookSubscription.
		 */
		public static function fromJSON( result:Object ):FacebookSubscription
		{
			var subscription:FacebookSubscription = new FacebookSubscription();
			subscription.fromJSON( result );
			return subscription;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ FacebookSubscriptionField.OBJECT ] );
		}
		
	}
}