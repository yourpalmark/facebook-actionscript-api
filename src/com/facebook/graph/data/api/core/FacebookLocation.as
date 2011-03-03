package com.facebook.graph.data.api.core
{
	import com.facebook.graph.core.facebook_internal;
	
	use namespace facebook_internal;
	
	/**
	 * A location.
	 */
	public class FacebookLocation extends AbstractFacebookGraphObject
	{
		/**
		 * The location's street.
		 */
		public var street:String;
		
		/**
		 * The location's city.
		 */
		public var city:String;
		
		/**
		 * The location's state.
		 */
		public var state:String;
		
		/**
		 * The location's zip.
		 */
		public var zip:String;
		
		/**
		 * The location's country.
		 */
		public var country:String;
		
		/**
		 * The location's latitude.
		 */
		public var latitude:Number;
		
		/**
		 * The location's longitude.
		 */
		public var longitude:Number;
		
		/**
		 * Creates a new FacebookLocation.
		 */
		public function FacebookLocation()
		{
		}
		
		/**
		 * Populates and returns a new FacebookLocation from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookLocation.
		 */
		public static function fromJSON( result:Object ):FacebookLocation
		{
			var location:FacebookLocation = new FacebookLocation();
			location.fromJSON( result );
			return location;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ "street", "city", "state", "zip", "country", "latitude", "longitude" ] );
		}
		
	}
}