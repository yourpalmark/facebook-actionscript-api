package com.facebook.graph.data.api.checkin
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.application.FacebookApplication;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	import com.facebook.graph.data.api.core.FacebookTag;
	import com.facebook.graph.data.api.page.FacebookPage;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	use namespace facebook_internal;
	
	/**
	 * A checkin.
	 * @see http://developers.facebook.com/docs/reference/api/checkin
	 */
	public class FacebookCheckin extends AbstractFacebookGraphObject
	{
		/**
		 * The ID and name of the user who made the checkin.
		 */
		public var from:FacebookUser;
		
		/**
		 * The users the author tagged in the checkin.
		 */
		public var tags:Array;
		
		/**
		 * Information about the Facebook Page that represents the location of the checkin.
		 */
		public var place:FacebookPage;
		
		/**
		 * The message the user added to the checkin.
		 */
		public var message:String;
		
		/**
		 * Information about the application that made the checkin.
		 */
		public var application:FacebookApplication;
		
		/**
		 * The time the checkin was created.
		 */
		public var created_time:Date;
		
		/**
		 * Creates a new FacebookCheckin.
		 */
		public function FacebookCheckin()
		{
		}
		
		/**
		 * Populates and returns a new FacebookCheckin from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookCheckin.
		 */
		public static function fromJSON( result:Object ):FacebookCheckin
		{
			var checkin:FacebookCheckin = new FacebookCheckin();
			checkin.fromJSON( result );
			return checkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookCheckinField.FROM:
					from = FacebookUser.fromJSON( value );
					break;
				
				case FacebookCheckinField.TAGS:
					tags = [];
					var tagsData:Array = value is Array ? value : Object( value ).hasOwnProperty( "data" ) && value.data is Array ? value.data : [];
					for each( var tagData:Object in tagsData )
					{
						tags.push( FacebookTag.fromJSON( tagData ) );
					}
					break;
				
				case FacebookCheckinField.APPLICATION:
					application = FacebookApplication.fromJSON( value );
					break;
				
				case FacebookCheckinField.PLACE:
					place = FacebookPage.fromJSON( value );
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
			return facebook_internal::toString( [ FacebookCheckinField.ID ] );
		}
		
	}
}