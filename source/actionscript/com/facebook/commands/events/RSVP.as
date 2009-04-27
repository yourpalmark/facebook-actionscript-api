/**
 * http://wiki.developers.facebook.com/index.php/Events.rsvp
 * Feb 18/09
 */ 
package com.facebook.commands.events {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The RSVP class represents the public  
      Facebook API known as Events.rsvp.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Events.rsvp
	 */
	public class RSVP extends FacebookCall {

		
		public static const METHOD_NAME:String = 'events.rsvp';
		public static const SCHEMA:Array = ['eid', 'rsvp_status'];
		
		public var eid:String;
		public var rsvp_status:String;
		
		public function RSVP(eid:String, rsvp_status:String) {
			super(METHOD_NAME);
			
			this.eid = eid;
			this.rsvp_status = rsvp_status;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, eid, rsvp_status);
			super.facebook_internal::initialize();
		}
	}
}