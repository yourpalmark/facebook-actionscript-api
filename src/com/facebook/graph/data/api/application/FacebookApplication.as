package com.facebook.graph.data.api.application
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * An application registered on Facebook Platform.
	 * @see http://developers.facebook.com/docs/reference/api/application
	 */
	public class FacebookApplication extends AbstractFacebookGraphObject
	{
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
		 * Populates and returns a new FacebookApplication from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookApplication.
		 */
		public static function fromJSON( result:Object ):FacebookApplication
		{
			var application:FacebookApplication = new FacebookApplication();
			application.fromJSON( result );
			return application;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ FacebookApplicationField.ID, FacebookApplicationField.NAME ] );
		}
		
	}
}