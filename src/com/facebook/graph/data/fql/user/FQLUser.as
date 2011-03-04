package com.facebook.graph.data.fql.user
{
	import com.facebook.graph.data.api.user.FacebookUser;
	import com.facebook.graph.utils.FacebookDataUtils;
	
	/**
	 * VO to hold information about a queried user.
	 */
	public class FQLUser
	{
		/**
		 * The user ID of the user being queried.
		 */
		public var uid:Number;
		
		/**
		 * The first name of the user being queried.
		 */
		public var first_name:String;
		
		/**
		 * The middle name of the user being queried.
		 */
		public var middle_name:String;
		
		/**
		 * The last name of the user being queried.
		 */
		public var last_name:String;
		
		/**
		 * The full name of the user being queried.
		 */
		public var name:String;
		
		/**
		 * The URL to the small-sized profile picture for the user being queried.
		 * The image can have a maximum width of 50px and a maximum height of 150px.
		 * This URL may be blank.
		 */
		public var pic_small:String;
		
		/**
		 * The URL to the largest-sized profile picture for the user being queried.
		 * The image can have a maximum width of 200px and a maximum height of 600px.
		 * This URL may be blank.
		 */
		public var pic_big:String;
		
		/**
		 * The URL to the square profile picture for the user being queried.
		 * The image can have a maximum width and height of 50px.
		 * This URL may be blank.
		 */
		public var pic_square:String;
		
		/**
		 * The URL to the medium-sized profile picture for the user being queried.
		 * The image can have a maximum width of 100px and a maximum height of 300px.
		 * This URL may be blank.
		 */
		public var pic:String;
		
		/**
		 * The networks to which the user being queried belongs.
		 * The status field within this field will only return results in English.
		 */
		public var affiliations:Array;
		
		/**
		 * The time the profile of the user being queried was most recently updated.
		 * If the user's profile has not been updated in the past three days, this value will be 0.
		 */
		public var profile_update_time:Date;
		
		/**
		 * The time zone where the user being queried is located.
		 */
		public var timezone:String;
		
		/**
		 * The religion of the user being queried.
		 */
		public var religion:String;
		
		/**
		 * The birthday of the user being queried.
		 * The format of this date varies based on the user's locale.
		 */
		public var birthday:String;
		
		/**
		 * The birthday of the user being queried, rendered as a machine-readable string.
		 * The format of this date never changes.
		 */
		public var birthday_date:Date;
		
		/**
		 * The gender of the user being queried.
		 * This field will only return results in English.
		 */
		public var sex:String;
		
		/**
		 * The home town (and state) of the user being queried.
		 */
		public var hometown_location:Array;
		
		/**
		 * A list of the genders the person the user being queried wants to meet.
		 */
		public var meeting_sex:Array;
		
		/**
		 * A list of the reasons the user being queried wants to meet someone.
		 */
		public var meeting_for:Array;
		
		/**
		 * The type of relationship for the user being queried.
		 * This field will only return results in English.
		 */
		public var relationship_status:String;
		
		/**
		 * The user ID of the partner (for example, husband, wife, boyfriend, girlfriend) of the user being queried.
		 */
		public var significant_other_id:Number;
		
		/**
		 * The political views of the user being queried.
		 */
		public var political:String;
		
		/**
		 * The current location of the user being queried.
		 */
		public var current_location:Array;
		
		/**
		 * The activities of the user being queried.
		 */
		public var activities:String;
		
		/**
		 * The interests of the user being queried.
		 */
		public var interests:String;
		
		/**
		 * Indicates whether the user being queried has logged in to the current application.
		 */
		public var is_app_user:Boolean;
		
		/**
		 * The favorite music of the user being queried.
		 */
		public var music:String;
		
		/**
		 * The favorite television shows of the user being queried.
		 */
		public var tv:String;
		
		/**
		 * The favorite movies of the user being queried.
		 */
		public var movies:String;
		
		/**
		 * The favorite books of the user being queried.
		 */
		public var books:String;
		
		/**
		 * The favorite quotes of the user being queried.
		 */
		public var quotes:String;
		
		/**
		 * More information about the user being queried.
		 */
		public var about_me:String;
		
		/**
		 * Information about high school of the user being queried.
		 */
		public var hs_info:Array;
		
		/**
		 * Post-high school information for the user being queried.
		 */
		public var education_history:Array;
		
		/**
		 * The work history of the user being queried.
		 */
		public var work_history:Array;
		
		/**
		 * The number of notes created by the user being queried.
		 */
		public var notes_count:int;
		
		/**
		 * The number of Wall posts for the user being queried.
		 */
		public var wall_count:int;
		
		/**
		 * The current status of the user being queried.
		 */
		public var status:String;
		
		/**
		 * Deprecated.
		 * This value is now equivalent to is_app_user.
		 */
		public var has_added_app:Boolean;
		
		/**
		 * The user's Facebook Chat status.
		 * Returns a string, one of active, idle, offline, or error (when Facebook can't determine presence information on the server side).
		 * The query does not return the user's Facebook Chat status when that information is restricted for privacy reasons.
		 */
		public var online_presence:String;
		
		/**
		 * The two-letter language code and the two-letter country code representing the user's locale.
		 * Country codes are taken from the ISO 3166 alpha 2 code list.
		 */
		public var locale:String;
		
		/**
		 * The proxied wrapper for a user's email address.
		 * If the user shared a proxied email address instead of his or her primary email address with you, this address also appears in the email field (see above).
		 * Facebook recommends you query the email field to get the email address shared with your application.
		 */
		public var proxied_email:String;
		
		/**
		 * The URL to a user's profile.
		 * If the user specified a username for his or her profile, profile_url contains the username.
		 */
		public var profile_url:String;
		
		/**
		 * An array containing a set of confirmed email hashes for the user.
		 * Emails are registered via the connect.registerUsers API call and are only confirmed when the user adds your application.
		 * The format of each email hash is the crc32 and md5 hashes of the email address combined with an underscore (_).
		 */
		public var email_hashes:Array;
		
		/**
		 * The URL to the small-sized profile picture for the user being queried.
		 * The image can have a maximum width of 50px and a maximum height of 150px, and is overlaid with the Facebook favicon.
		 * This URL may be blank.
		 */
		public var pic_small_with_logo:String;
		
		/**
		 * The URL to the largest-sized profile picture for the user being queried.
		 * The image can have a maximum width of 200px and a maximum height of 600px, and is overlaid with the Facebook favicon.
		 * This URL may be blank.
		 */
		public var pic_big_with_logo:String;
		
		/**
		 * The URL to the square profile picture for the user being queried.
		 * The image can have a maximum width and height of 50px, and is overlaid with the Facebook favicon.
		 * This URL may be blank.
		 */
		public var pic_square_with_logo:String;
		
		/**
		 * The URL to the medium-sized profile picture for the user being queried.
		 * The image can have a maximum width of 100px and a maximum height of 300px, and is overlaid with the Facebook favicon.
		 * This URL may be blank.
		 */
		public var pic_with_logo:String;
		
		/**
		 * A comma-delimited list of Demographic Restrictions types a user is allowed to access.
		 * Currently, alcohol is the only type that can get returned.
		 */
		public var allowed_restrictions:String;
		
		/**
		 * Indicates whether or not Facebook has verified the user.
		 */
		public var verified:Boolean;
		
		/**
		 * This string contains the contents of the text box under a user's profile picture.
		 */
		public var profile_blurb:String;
		
		/**
		 * Note: For family information, you should query the family FQL table instead.
		 * 
		 * This array contains a series of entries for the immediate relatives of the user being queried.
		 * Each entry is also an array containing the following fields:
		 * 
		 * relationship -- A string describing the type of relationship.
		 * 		Can be one of parent, mother, father, sibling, sister, brother, child, son, daughter.
		 * uid (optional) -- The user ID of the relative, which gets displayed if the account is linked to (confirmed by) another account.
		 * 		If the relative did not confirm the relationship, the name appears instead.
		 * name (optional) -- The name of the relative, which could be text the user entered.
		 * 		If the relative confirmed the relationship, the uid appears instead.
		 * birthday -- If the relative is a child, this is the birthday the user entered.
		 * 
		 * Note: At this time, you cannot query for a specific relationship (like SELECT family FROM user WHERE family.relationship = 'daughter' AND uid = '$x');
		 * you'll have to query on the family field and filter the results yourself.
		 */
		public var family:Array;
		
		/**
		 * The username of the user being queried.
		 */
		public var username:String;
		
		/**
		 * The website of the user being queried.
		 */
		public var website:String;
		
		/**
		 * Returns true if the user is blocked to the viewer/logged in user.
		 */
		public var is_blocked:Boolean;
		
		/**
		 * A string containing the user's primary Facebook email address.
		 * If the user shared his or her primary email address with you, this address also appears in the email field (see below).
		 * Facebook recommends you query the email field to get the email address shared with your application.
		 */
		public var contact_email:String;
		
		/**
		 * A string containing the user's primary Facebook email address or the user's proxied email address, whichever address the user granted your application.
		 * Facebook recommends you query this field to get the email address shared with your application.
		 */
		public var email:String;
		
		/**
		 * A string containing an anonymous, but unique identifier for the user.
		 * You can use this identifier with third-parties..
		 */
		public var third_party_id:String;
		
		/**
		 * Creates a new FQLUser.
		 */
		public function FQLUser()
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
						case "profile_update_time":
						case "birthday_date":
							if( hasOwnProperty( property ) ) this[ property ] = FacebookDataUtils.stringToDate( result[ property ] );
							break;
						
						default:
							if( hasOwnProperty( property ) ) this[ property ] = result[ property ];
							break;
					}
				}
			}
		}
		
		/**
		 * Populates a FacebookUser from the available properties of this instance.
		 */
		public function toFacebookUser():FacebookUser
		{
			var facebookUser:FacebookUser = new FacebookUser();
			facebookUser.id = !isNaN( uid ) ? uid.toString() : null;
			facebookUser.first_name = first_name;
			facebookUser.last_name = last_name;
			facebookUser.name = name;
			facebookUser.picture = pic_square ? pic_square : pic_square_with_logo ? pic_square_with_logo : pic_small ? pic_small : pic_small_with_logo ? pic_small_with_logo : pic ? pic : pic_with_logo ? pic_with_logo : pic_big ? pic_big : pic_big_with_logo ? pic_big_with_logo : null;
			facebookUser.link = profile_url;
			facebookUser.about = about_me;
			facebookUser.birthday = birthday;
			facebookUser.work = work_history ? work_history.concat() : null;
			facebookUser.education = education_history ? education_history.concat() : null;
			facebookUser.email = email;
			facebookUser.website = website;
			facebookUser.hometown = hometown_location && hometown_location.length > 0 ? hometown_location[ 0 ] : null;
			facebookUser.location = current_location && current_location.length > 0 ? current_location[ 0 ] : null;
			facebookUser.quotes = quotes;
			facebookUser.gender = sex;
			facebookUser.interested_in = meeting_sex && meeting_sex.length > 0 ? meeting_sex.join( "," ) : null;
			facebookUser.meeting_for = meeting_for && meeting_for.length > 0 ? meeting_for.join( "," ) : null;
			facebookUser.relationship_status = relationship_status;
			facebookUser.religion = religion;
			facebookUser.political = political;
			facebookUser.verified = verified;
			if( !isNaN( significant_other_id ) )
			{
				facebookUser.significant_other = new FacebookUser();
				facebookUser.significant_other.id = significant_other_id.toString();
			}
			facebookUser.timezone = timezone ? parseInt( timezone ) : 0;
			facebookUser.locale = locale;
			facebookUser.updated_time = profile_update_time;
			return facebookUser;
		}
		
		/**
		 * Provides the string value of this instance.
		 */
		public function toString():String
		{
			return '[ uid: ' + uid + ', name: ' + name + ' ]';
		}
		
	}
}