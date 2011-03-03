package com.facebook.graph.data.api.page
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	import com.facebook.graph.data.api.core.FacebookLocation;
	
	use namespace facebook_internal;
	
	/**
	 * A Facebook Page.
	 * @see http://developers.facebook.com/docs/reference/api/page
	 */
	public class FacebookPage extends AbstractFacebookGraphObject
	{
		/**
		 * The Page's name.
		 */
		public var name:String;
		
		/**
		 * The Page's category.
		 */
		public var category:String;
		
		/**
		 * The number of users who like the Page.
		 */
		public var likes:Number;
		
		/**
		 * The Page's location.
		 */
		public var location:FacebookLocation;
		
		/**
		 * Creates a new FacebookPage.
		 */
		public function FacebookPage()
		{
		}
		
		/**
		 * Populates and returns a new FacebookPage from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookPage.
		 */
		public static function fromJSON( result:Object ):FacebookPage
		{
			var page:FacebookPage = new FacebookPage();
			page.fromJSON( result );
			return page;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case "fan_count":
					likes = value;
					break;
				
				case "location":
					location = FacebookLocation.fromJSON( value );
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
			return facebook_internal::toString( [ FacebookPageField.ID, FacebookPageField.NAME ] );
		}
		
	}
}