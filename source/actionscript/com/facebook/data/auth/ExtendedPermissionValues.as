/**
 * ENUM Class for Facebook.grantExtendedPermission(), method
 * http://wiki.developers.facebook.com/index.php/UsageNotes/Forms#Prompting_a_User_for_an_Extended_Permission
 * Feb 18/09
 * 
 * Last Update - April 10/09
 */
package com.facebook.data.auth {
	
	[Bindable]
	public class ExtendedPermissionValues {
		
		public static const EMAIL:String = 'email';
		public static const OFFLINE_ACCESS:String = 'offline_access';
		public static const STATUS_UPDATE:String = 'status_update';
		public static const PHOTO_UPLOAD:String = 'photo_upload';
		public static const CREATE_EVENT:String = 'create_event';
		public static const CREATE_NOTE:String = 'create_note';
		public static const RSVP_EVENT:String = 'rsvp_event';
		public static const SMS:String = 'sms';
		public static const SHARE_ITEM:String = 'share_item';
		
		/**
		 *  Lets your application post content, comments, and likes
		 * 	to a user's proﬁle and in the streams of the user's friends. 
		 * 
		 */
		public static const PUBLISH_STREAM:String = 'publish_stream';
		
		/**
		 * Permission is similar to republish_stream,
		 * but is subject to Storable_Information policies on storing user informaion.  
		 * 
		 */
		public static const READ_STREAM:String = 'read_stream';
	}
}