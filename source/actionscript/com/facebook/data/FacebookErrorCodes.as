package com.facebook.data {
	
	/**
	 * An enumeration class that defines all the possible error codes returned from the Facebook API.
	 * 
	 * @see http://wiki.developers.facebook.com/index.php/Error_codes
	 */
	[Bindable]
	public class FacebookErrorCodes {
		
		public static const SERVER_ERROR:Number = -1; //Defines a server error from Flash. 
		
		public static const API_EC_SUCCESS:Number = 0;//Success 	 (all);
		public static const API_EC_UNKNOWN:Number = 1;//An unknown error occurred 	(all)
		public static const API_EC_SERVICE:Number = 2;//Service temporarily unavailable 	(all)
		public static const API_EC_METHOD:Number = 3;//Unknown method
		public static const API_EC_TOO_MANY_CALLS:Number = 4;//Application request limit reached 	(all)
		public static const API_EC_BAD_IP:Number = 5;//Unauthorized source IP address 	(all)
		public static const API_EC_HOST_API:Number = 6;//This method must run on api.facebook.com 	(all)
		public static const API_EC_HOST_UP:Number = 7;//This method must run on api-video.facebook.com
		public static const API_EC_SECURE:Number = 8;//This method requires an HTTPS connection
		public static const API_EC_RATE:Number = 9;//User is performing too many actions
		public static const API_EC_PERMISSION_DENIED:Number = 10;//Application does not have permission for this action
		public static const API_EC_DEPRECATED:Number = 11;//This method is deprecated
		public static const API_EC_VERSION:Number = 12;//This API version is deprecated 
		
	}
}