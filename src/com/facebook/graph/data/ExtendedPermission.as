package com.facebook.graph.data
{
	/**
	 * Enum class for extended permissions.
	 * @see http://developers.facebook.com/docs/authentication/permissions
	 */
	public class ExtendedPermission
	{
		//DATA PERMISSIONS
		/**
		 * Provides access to the "About Me" section of the profile in the about property.
		 */
		public static const USER_ABOUT_ME:String = "user_about_me";
		public static const FRIENDS_ABOUT_ME:String = "friends_about_me";
		
		/**
		 * Provides access to the user's list of activities as the activities connection.
		 */
		public static const USER_ACTIVITIES:String = "user_activities";
		public static const FRIENDS_ACTIVITIES:String = "friends_activities";
		
		/**
		 * Provides access to the full birthday with year as the birthday_date property.
		 */
		public static const USER_BIRTHDAY:String = "user_birthday";
		public static const FRIENDS_BIRTHDAY:String = "friends_birthday";
		
		/**
		 * Provides access to education history as the education property.
		 */
		public static const USER_EDUCATION_HISTORY:String = "user_education_history";
		public static const FRIENDS_EDUCATION_HISTORY:String = "friends_education_history";
		
		/**
		 * Provides access to the list of events the user is attending as the events connection.
		 */
		public static const USER_EVENTS:String = "user_events";
		public static const FRIENDS_EVENTS:String = "friends_events";
		
		/**
		 * Provides access to the list of groups the user is a member of as the groups connection.
		 */
		public static const USER_GROUPS:String = "user_groups";
		public static const FRIENDS_GROUPS:String = "friends_groups";
		
		/**
		 * Provides access to the user's hometown in the hometown property.
		 */
		public static const USER_HOMETOWN:String = "user_hometown";
		public static const FRIENDS_HOMETOWN:String = "friends_hometown";
		
		/**
		 * Provides access to the user's list of interests as the interests connection.
		 */
		public static const USER_INTERESTS:String = "user_interests";
		public static const FRIENDS_INTERESTS:String = "friends_interests";
		
		/**
		 * Provides access to the list of all of the pages the user has liked as the likes connection.
		 */
		public static const USER_LIKES:String = "user_likes";
		public static const FRIENDS_LIKES:String = "friends_likes";
		
		/**
		 * Provides access to the user's current location as the current_location property.
		 */
		public static const USER_LOCATION:String = "user_location";
		public static const FRIENDS_LOCATION:String = "friends_location";
		
		/**
		 * Provides access to the user's notes as the notes connection.
		 */
		public static const USER_NOTES:String = "user_notes";
		public static const FRIENDS_NOTES:String = "friends_notes";
		
		/**
		 * Provides access to the user's online/offline presence.
		 */
		public static const USER_ONLINE_PRESENCE:String = "user_online_presence";
		public static const FRIENDS_ONLINE_PRESENCE:String = "friends_online_presence";
		
		/**
		 * Provides access to the photos the user has been tagged in as the photos connection.
		 */
		public static const USER_PHOTO_VIDEO_TAGS:String = "user_photo_video_tags";
		public static const FRIENDS_PHOTO_VIDEO_TAGS:String = "friends_photo_video_tags";
		
		/**
		 * Provides access to the photos the user has uploaded.
		 */
		public static const USER_PHOTOS:String = "user_photos";
		public static const FRIENDS_PHOTOS:String = "friends_photos";
		
		/**
		 * Provides access to the user's family and personal relationships and relationship status.
		 */
		public static const USER_RELATIONSHIPS:String = "user_relationships";
		public static const FRIENDS_RELATIONSHIPS:String = "friends_relationships";
		
		/**
		 * Provides access to the user's relationship preferences.
		 */
		public static const USER_RELATIONSHIP_DETAILS:String = "user_relationship_details";
		public static const FRIENDS_RELATIONSHIP_DETAILS:String = "friends_relationship_details";
		
		/**
		 * Provides access to the user's religious and political affiliations.
		 */
		public static const USER_RELIGION_POLITICS:String = "user_religion_politics";
		public static const FRIENDS_RELIGION_POLITICS:String = "friends_religion_politics";
		
		/**
		 * Provides access to the user's most recent status message.
		 */
		public static const USER_STATUS:String = "user_status";
		public static const FRIENDS_STATUS:String = "friends_status";
		
		/**
		 * Provides access to the videos the user has uploaded.
		 */
		public static const USER_VIDEOS:String = "user_videos";
		public static const FRIENDS_VIDEOS:String = "friends_videos";
		
		/**
		 * Provides access to the user's web site URL.
		 */
		public static const USER_WEBSITE:String = "user_website";
		public static const FRIENDS_WEBSITE:String = "friends_website";
		
		/**
		 * Provides access to work history as the work property.
		 */
		public static const USER_WORK_HISTORY:String = "user_work_history";
		public static const FRIENDS_WORK_HISTORY:String = "friends_work_history";
		
		/**
		 * Provides access to the user's primary email address in the email property.
		 * Do not spam users.
		 * Your use of email must comply both with Facebook policies and with the CAN-SPAM Act.
		 */
		public static const EMAIL:String = "email";
		
		/**
		 * Provides access to any friend lists the user created.
		 * All user's friends are provided as part of basic data, this extended permission grants access to the lists of friends a user has created, and should only be requested if your application utilizes lists of friends.
		 */
		public static const READ_FRIENDLISTS:String = "read_friendlists";
		public static const MANAGE_FRIENDLISTS:String = "manage_friendlists";
		
		/**
		 * Provides read access to the Insights data for pages, applications, and domains the user owns.
		 */
		public static const READ_INSIGHTS:String = "read_insights";
		
		/**
		 * Provides the ability to read from a user's Facebook Inbox.
		 * You must request to be whitelisted before you can prompt for this permission.
		 */
		public static const READ_MAILBOX:String = "read_mailbox";
		
		/**
		 * Provides read access to the user's friend requests.
		 */
		public static const READ_REQUESTS:String = "read_requests";
		
		/**
		 * Provides access to all the posts in the user's News Feed and enables your application to perform searches against the user's News Feed.
		 */
		public static const READ_STREAM:String = "read_stream";
		
		/**
		 * Provides applications that integrate with Facebook Chat the ability to log in users.
		 */
		public static const XMPP_LOGIN:String = "xmpp_login";
		
		/**
		 * Provides the ability to manage ads and call the Facebook Ads API on behalf of a user.
		 */
		public static const ADS_MANAGEMENT:String = "ads_management";
		
		/**
		 * Provides read access to the authorized user's check-ins or a friend's check-ins that the user can see.
		 */
		public static const USER_CHECKINS:String = "user_checkins";
		public static const FRIENDS_CHECKINS:String = "friends_checkins";
		
		//PUBLISHING PERMISSIONS
		/**
		 * Enables your application to post content, comments, and likes to a user's stream and to the streams of the user's friends.
		 * Read these best practices about publishing.
		 */
		public static const PUBLISH_STREAM:String = "publish_stream";
		
		/**
		 * Enables your application to create and modify events on the user's behalf.
		 */
		public static const CREATE_EVENT:String = "create_event";
		
		/**
		 * Enables your application to RSVP to events on the user's behalf.
		 */
		public static const RSVP_EVENT:String = "rsvp_event";
		
		/**
		 * Enables your application to send messages to the user and respond to messages from the user via text message.
		 */
		public static const SMS:String = "sms";
		
		/**
		 * Enables your application to perform authorized requests on behalf of the user at any time.
		 * By default, most access tokens expire after a short time period to ensure applications only make requests on behalf of the user when the are actively using the application.
		 * This permission makes the access token returned by our OAuth endpoint long-lived.
		 */
		public static const OFFLINE_ACCESS:String = "offline_access";
		
		/**
		 * Enables your application to perform checkins on behalf of the user.
		 */
		public static const PUBLISH_CHECKINS:String = "publish_checkins";
		
		//PAGE PERMISSIONS
		/**
		 * Enables your application to retrieve access_tokens for pages the user administrates.
		 * The access tokens can be queried using the "accounts" connection in the Graph API.
		 * This permission is only compatible with the Graph API.
		 */
		public static const MANAGE_PAGES:String = "manage_pages";
		
	}
}