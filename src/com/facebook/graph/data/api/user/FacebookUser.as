package com.facebook.graph.data.api.user
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * A user profile.
	 * @see http://developers.facebook.com/docs/reference/api/user
	 */
	public class FacebookUser extends AbstractFacebookGraphObject
	{
		/**
		 * The user's full name.
		 */
		public var name:String;
		
		/**
		 * The user's first name.
		 */
		public var first_name:String;
		
		/**
		 * The user's last name.
		 */
		public var last_name:String;
		
		/**
		 * The user's gender.
		 */
		public var gender:String;
		
		/**
		 * The user's locale.
		 */
		public var locale:String;
		
		/**
		 * A link to the user's profile.
		 */
		public var link:String;
		
		/**
		 * The user's Facebook username.
		 */
		public var username:String;
		
		/**
		 * An anonymous, but unique identifier for the user.
		 */
		public var third_party_id:String;
		
		/**
		 * The user's timezone offset from UTC.
		 */
		public var timezone:Number;
		
		/**
		 * The last time the user's profile was updated.
		 */
		public var updated_time:Date;
		
		/**
		 * The user's account verification status.
		 */
		public var verified:Boolean;
		
		/**
		 * The blurb that appears under the user's profile picture.
		 */
		public var about:String;
		
		/**
		 * The user's biography.
		 */
		public var bio:String;
		
		/**
		 * The user's birthday.
		 */
		public var birthday:String;
		
		/**
		 * A list of the user's education history.
		 */
		public var education:Array;
		
		/**
		 * The proxied or contact email address granted by the user.
		 */
		public var email:String;
		
		/**
		 * The user's hometown.
		 */
		public var hometown:Object;
		
		/**
		 * The genders the user is interested in.
		 */
		public var interested_in:String;
		
		/**
		 * The user's current location.
		 */
		public var location:Object;
		
		/**
		 * The types of relationships the user is seeking.
		 */
		public var meeting_for:String;
		
		/**
		 * The user's political view.
		 */
		public var political:String;
		
		/**
		 * The user's favorite quotes.
		 */
		public var quotes:String;
		
		/**
		 * The user's relationship status.
		 */
		public var relationship_status:String;
		
		/**
		 * The user's religion.
		 */
		public var religion:String;
		
		/**
		 * The user's significant other.
		 */
		public var significant_other:FacebookUser;
		
		/**
		 * The URL of the user's personal website.
		 */
		public var website:String;
		
		/**
		 * A list of the user's work history.
		 */
		public var work:Array;
		
		/**
		 * The user's profile picture.
		 */
		public var picture:String;
		
		/**
		 * Creates a new FacebookUser.
		 */
		public function FacebookUser()
		{
		}
		
		/**
		 * Populates and returns a new FacebookUser from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookUser.
		 */
		public static function fromJSON( result:Object ):FacebookUser
		{
			var user:FacebookUser = new FacebookUser();
			user.fromJSON( result );
			return user;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookUserField.SIGNIFICANT_OTHER:
					significant_other = FacebookUser.fromJSON( value );
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
			return facebook_internal::toString( [ FacebookUserField.ID, FacebookUserField.NAME ] );
		}
		
	}
}