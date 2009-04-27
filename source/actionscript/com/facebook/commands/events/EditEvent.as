/**
 * http://wiki.developers.facebook.com/index.php/Events.edit
 * Feb 18/09
 */ 
package com.facebook.commands.events {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.data.events.EditEventData;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;

	use namespace facebook_internal;

	/**
	 * The EditEvent class represents the public  
      Facebook API known as Events.edit.
	 * @see http://wiki.developers.facebook.com/index.php/Events.edit
	 */
	public class EditEvent extends FacebookCall {

		
		public static const METHOD_NAME:String = 'events.edit';
		public static const SCHEMA:Array = ['eid', 'event_info'];
		
		public var eid:String;
		public var event_info:EditEventData;
		
		public function EditEvent(eid:String, event_info:EditEventData) {
			super(METHOD_NAME);
			
			this.eid = eid;
			this.event_info = event_info;
		}
		
		override facebook_internal function initialize():void {
			
			var o:Object = {}
			for each(var n:String in event_info.schema) {
				var value:Object = event_info[n];
				if (value is Date) { value = FacebookDataUtils.toDateString(value as Date); }
				o[n] = value;
			}
			
			applySchema(SCHEMA, eid, JSON.encode(event_info));
			super.facebook_internal::initialize();
		}
	}
}