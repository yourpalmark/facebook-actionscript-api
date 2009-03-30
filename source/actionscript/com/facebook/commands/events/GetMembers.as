/**
 * http://wiki.developers.facebook.com/index.php/Events.getMembers
 * Feb 18/09
 */ 
package com.facebook.commands.events {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetMembers class represents the public  
      Facebook API known as Events.getMembers.
	 * @see http://wiki.developers.facebook.com/index.php/Events.getMembers
	 */
	public class GetMembers extends FacebookCall {

		
		public static var METHOD_NAME:String = 'events.getMembers';
		public static var SCHEMA:Array = ['eid'];
		
		public var eid:String;
		
		public function GetMembers(eid:String) {
			super(METHOD_NAME);
			
			this.eid = eid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, eid);
			super.facebook_internal::initialize();
		}
	}
}