package com.facebook.graph.data.api.insights
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * An individual data point for the insight.
	 * @see http://developers.facebook.com/docs/reference/api/insights
	 */
	public class FacebookInsightsValue extends AbstractFacebookGraphObject
	{
		/**
		 * The value of the requested metric.
		 */
		public var value:Number;
		
		/**
		 * The end of the period during which the metrics were collected.
		 */
		public var end_time:Date;
		
		/**
		 * Creates a new FacebookInsightsValue.
		 */
		public function FacebookInsightsValue()
		{
		}
		
		/**
		 * Populates and returns a new FacebookInsightsValue from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookInsightsValue.
		 */
		public static function fromJSON( result:Object ):FacebookInsightsValue
		{
			var value:FacebookInsightsValue = new FacebookInsightsValue();
			value.fromJSON( result );
			return value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ "value" ] );
		}
		
	}
}