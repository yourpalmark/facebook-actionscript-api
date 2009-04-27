/**
 * http://wiki.developers.facebook.com/index.php/Events.edit
 * Feb 18/09
 */ 
package com.facebook.commands.events {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetEvents class represents the public  
      Facebook API known as Events.get.
	 * @see http://wiki.developers.facebook.com/index.php/Events.get
	 */
	public class GetEvents extends FacebookCall {

		
		public static const METHOD_NAME:String = 'events.get';
		public static const SCHEMA:Array = ['uid', 'eids', 'start_time', 'end_time', 'rsvp_status'];
		
		public var uid:String;
		public var eids:Array;
		public var start_time:Date;
		public var end_time:Date;
		public var rsvp_status:String;
		
		public function GetEvents(uid:String = null, eids:Array = null, start_time:Date = null, end_time:Date = null, rsvp_status:String = null) {
			super(METHOD_NAME);
			
			this.uid = uid;
			this.eids = eids;
			this.start_time = start_time;
			this.end_time = end_time;
			this.rsvp_status = rsvp_status;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid, FacebookDataUtils.toArrayString(eids), FacebookDataUtils.toDateString(start_time),  FacebookDataUtils.toDateString(end_time), rsvp_status);
			super.facebook_internal::initialize();
		}
	}
}