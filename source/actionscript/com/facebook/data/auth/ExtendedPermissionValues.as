package com.facebook.data.auth {
	/**
	 * Enumeration Class for the Facebook.grantExtendedPermission() method.
	 * 
	 * @see com.facebook.Facebook#grantExtendedPermission()
	 * @see http://wiki.developers.facebook.com/index.php/UsageNotes/Forms#Prompting_a_User_for_an_Extended_Permission
	 */
	
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
		
	}
}