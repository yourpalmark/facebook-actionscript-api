package com.facebook.graph.data.api.user
{
	import com.adobe.utils.DateUtil;
	
	/**
	 * A user profile.
	 * @see http://developers.facebook.com/docs/reference/api/user
	 */
	public class FacebookUser
	{
		/**
		 * The user's ID.
		 */
		public var id:String;
		
		/**
		 * The user's first name.
		 */
		public var first_name:String;
		
		/**
		 * The user's last name.
		 */
		public var last_name:String;
		
		/**
		 * The user's full name.
		 */
		public var name:String;
		
		/**
		 * The user's profile picture.
		 */
		public var picture:String;
		
		/**
		 * A link to the user's profile.
		 */
		public var link:String;
		
		/**
		 * The user's blurb that appears under their profile picture.
		 */
		public var about:String;
		
		/**
		 * The user's birthday.
		 */
		public var birthday:String;
		
		/**
		 * A list of the work history from the user's profile.
		 */
		public var work:Array;
		
		/**
		 * A list of the education history from the user's profile.
		 */
		public var education:Array;
		
		/**
		 * The proxied or contact email address granted by the user.
		 */
		public var email:String;
		
		/**
		 * A link to the user's personal website.
		 */
		public var website:String;
		
		/**
		 * The user's hometown.
		 */
		public var hometown:Object;
		
		/**
		 * The user's current location.
		 */
		public var location:Object;
		
		/**
		 * The user's bio.
		 */
		public var bio:String;
		
		/**
		 * The user's favorite quotes.
		 */
		public var quotes:String;
		
		/**
		 * The user's gender.
		 */
		public var gender:String;
		
		/**
		 * Genders the user is interested in.
		 */
		public var interested_in:String;
		
		/**
		 * Types of relationships the user is seeking.
		 */
		public var meeting_for:String;
		
		/**
		 * The user's relationship status.
		 */
		public var relationship_status:String;
		
		/**
		 * The user's religion.
		 */
		public var religion:String;
		
		/**
		 * The user's political view.
		 */
		public var political:String;
		
		/**
		 * The user's account verification status.
		 */
		public var verified:Boolean;
		
		/**
		 * The user's significant other.
		 */
		public var significant_other:FacebookUser;
		
		/**
		 * The user's timezone.
		 */
		public var timezone:int;
		
		/**
		 * The user's locale.
		 */
		public var locale:String;
		
		/**
		 * The time the user was most recently updated.
		 */
		public var updated_time:Date;
		
		/**
		 * Creates a new FacebookUser.
		 */
		public function FacebookUser()
		{
		}
		
		/**
		 * Populates the user from a decoded JSON object.
		 */
		public function fromJSON( result:Object ):void
		{
			if( result != null )
			{
				for( var property:String in result )
				{
					switch( property )
					{
						case "significant_other":
							significant_other = new FacebookUser();
							significant_other.fromJSON( result[ property ] );
							break;
						
						case "updated_time":
							updated_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						default:
							if( hasOwnProperty( property ) ) this[ property ] = result[ property ];
							break;
					}
				}
			}
		}
		
		/**
		 * Provides the string value of the user.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}