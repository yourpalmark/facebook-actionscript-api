/**
 * Values for admin.getAllocation command
 * As defined in http://wiki.developers.facebook.com/index.php/Admin.getAllocation, Feb 3, 2009
 * 
 */
package com.facebook.data.admin {
	
	[Bindable]
	public class GetAllocationValues {
		
		/**
		 * The number of notifications your application can send on behalf of a user per day. These are user-to-user notifications. 
		 * 
		 */
		public static const NOTIFICATIONS_PER_DAY:String = 'notifications_per_day';
		
		/**
		 * The number of notifications your application can send to a user per week. These are application-to-user notifications. 
		 * 
		 */
		public static const ANNOUNCEMENT_NOTIFICATIONS_PER_WEEK:String = 'announcement_notifications_per_week';
		
		/**
		 * The number of requests your application can send on behalf of a user per day. 
		 * 
		 */
		public static const REQUESTS_PER_DAY:String = 'requests_per_day';
		
		/**
		 * The number of email messages your application can send to a user per day. 
		 * 
		 */
		public static const EMAILS_PER_DAY:String = 'emails_per_day';
		
		/**
		 * The location of the disable message within emails sent by your application. '1' is the bottom of the message and '2' is the top of the message.
		 * 
		 */
		public static const EMAIL_DISABLE_MESSAGE_LOCATION:String = 'email_disable_message_location';
		
	}
}