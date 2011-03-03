package com.facebook.graph.data.api.insights
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * Statistics about applications, pages, and domains.
	 * @see http://developers.facebook.com/docs/reference/api/insights
	 */
	public class FacebookInsights extends AbstractFacebookGraphObject
	{
		/**
		 * Name of the insight.
		 */
		public var name:String;
		
		/**
		 * Length of the period during which the insights were collected.
		 */
		public var period:String;
		
		/**
		 * Individual data points for the insight.
		 */
		public var values:Array;
		
		/**
		 * Creates a new FacebookInsights.
		 */
		public function FacebookInsights()
		{
		}
		
		/**
		 * Populates and returns a new FacebookInsights from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookInsights.
		 */
		public static function fromJSON( result:Object ):FacebookInsights
		{
			var insights:FacebookInsights = new FacebookInsights();
			insights.fromJSON( result );
			return insights;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookInsightsField.VALUES:
					values = [];
					var valuesData:Array = value is Array ? value : Object( value ).hasOwnProperty( "data" ) && value.data is Array ? value.data : [];
					for each( var valueData:Object in valuesData )
					{
						values.push( FacebookInsightsValue.fromJSON( valueData ) );
					}
					break;
				
				default:
					super.setPropertyValue( property, value );
					break;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ FacebookInsightsField.ID, FacebookInsightsField.NAME ] );
		}
		
	}
}