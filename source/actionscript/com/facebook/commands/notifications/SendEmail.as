/**
 * http://wiki.developers.facebook.com/index.php/Notifications.sendEmail
 * Date:Feb 18/09
 * 
 */
package com.facebook.commands.notifications {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The SendEmail class represents the public  
      Facebook API known as Notifications.sendEmail.
	 * @see http://wiki.developers.facebook.com/index.php/Notifications.sendEmail
	 */
	public class SendEmail extends FacebookCall {

		
		public static const METHOD_NAME:String = 'notifications.sendEmail';
		public static const SCHEMA:Array = ['recipients', 'subject', 'text', 'subject'];
		
		public var recipients:Array;
		public var subject:String;
		public var text:String;
		public var fbml:String;
		
		public function SendEmail(recipients:Array, subject:String, text:String, fbml:String) { 
			super(METHOD_NAME);
			
			this.recipients = recipients;
			this.subject = subject;
			this.text = text;
			this.fbml = fbml;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(recipients), subject, text, fbml);
			super.facebook_internal::initialize();
		}
	}
}