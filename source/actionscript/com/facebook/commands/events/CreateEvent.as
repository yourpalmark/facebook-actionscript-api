/**
 * http://wiki.developers.facebook.com/index.php/Events.cancel
 * Feb 18/09
 */ 
package com.facebook.commands.events {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.data.events.CreateEventData;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;

	use namespace facebook_internal;

	/**
	 * The CreateEvent class represents the public  
      Facebook API known as Events.create.
	 * @see http://wiki.developers.facebook.com/index.php/Events.create
	 */
	public class CreateEvent extends FacebookCall {

		
		public static var METHOD_NAME:String = 'events.create';
		public static var SCHEMA:Array = ['event_info'];
		
		public var event_info:CreateEventData;
		
		public function CreateEvent(event_info:CreateEventData) {
			super(METHOD_NAME);
			
			this.event_info = event_info;
		}
		
		override facebook_internal function initialize():void {
			
			var o:Object = {}
			for each(var n:String in event_info.schema) {
				var value:Object = event_info[n];
				if (value is Date) { value = FacebookDataUtils.toDateString(value as Date); }
				o[n] = value;
			}
			
			applySchema(SCHEMA, JSON.encode(o));
			super.facebook_internal::initialize();
		}
	}
}