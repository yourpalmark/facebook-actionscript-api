/**
 * http://wiki.developers.facebook.com/index.php/Events.cancel
 * Feb 18/09
 */ 
package com.facebook.commands.events {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The CancelEvent class represents the public  
      Facebook API known as Events.cancel.
	 * @see http://wiki.developers.facebook.com/index.php/Events.cancel
	 */
	public class CancelEvent extends FacebookCall {

		
		public static const METHOD_NAME:String = 'events.cancel';
		public static const SCHEMA:Array = ['eid', 'cancel_message'];
		
		public var eid:String;
		public var cancel_message:String;
		
		public function CancelEvent(eid:String, cancel_message:String = null) {
			super(METHOD_NAME);
			
			this.eid = eid;
			this.cancel_message = cancel_message;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, eid, cancel_message);
			super.facebook_internal::initialize();
		}
	}
}