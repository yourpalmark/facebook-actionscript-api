/**
 * http://wiki.developers.facebook.com/index.php/LiveMessage.send
 * Feb 18/09; 
 */
package com.facebook.commands.livemessage {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The SendLiveMessage class represents the public  
      Facebook API known as LiveMessage.send.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/LiveMessage.send
	 */
	public class SendLiveMessage extends FacebookCall {

		
		public static var METHOD_NAME:String = 'liveMessage.send';
		public static var SCHEMA:Array = ['recipient', 'event_name', 'message'];
		
		public var recipient:String;
		public var event_name:String;
		public var message:String;
		
		public function SendLiveMessage(recipient:String, event_name:String, message:String) {
			super(METHOD_NAME);
			
			this.recipient = recipient;
			this.event_name = event_name;
			this.message = message;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, recipient, event_name, message);
			super.facebook_internal::initialize();
		}
	}
}