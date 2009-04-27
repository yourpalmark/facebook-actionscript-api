/**
 * http://wiki.developers.facebook.com/index.php/Notifications.send
 * Date:Feb 10/09
 * 
 */
package com.facebook.commands.notifications {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The SendNotification class represents the public  
      Facebook API known as Notifications.send.
	 * @see http://wiki.developers.facebook.com/index.php/Notifications.send
	 */
	public class SendNotification extends FacebookCall {

		
		public static const METHOD_NAME:String = 'notifications.send';
		public static const SCHEMA:Array = ['to_ids','notification','type'];
		
		public var to_ids:Array;
		public var notification:String;
		public var type:String;
		
		public function SendNotification(to_ids:Array,notification:String,type:String=null){ 
			super(METHOD_NAME);
			
			this.to_ids = to_ids;
			this.notification = notification;
			this.type = type;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(to_ids), notification, type);
			super.facebook_internal::initialize();
		}
	}
}