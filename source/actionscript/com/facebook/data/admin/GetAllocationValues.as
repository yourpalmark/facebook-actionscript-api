package com.facebook.data.admin {
	
	/**
 	 * Enumeration class for possible values of the <code>integration_point_name</code> parameter of the admin.getAllocation command.
 	 * The constants in this class represent the various integration points that can be queried by the
 	 * admin.getAllocation command. Select one of these constants to send as the <code>integration_point_name</code>
 	 * parameter of the admin.getAllocation command.
 	 * 
 	 * @see com.facebook.commands.admin.GetAllocation
 	 * @see http://wiki.developers.facebook.com/index.php/Admin.getAllocation
 	 */
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