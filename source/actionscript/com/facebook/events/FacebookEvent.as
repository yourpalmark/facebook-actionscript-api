package com.facebook.events {
	
	import com.facebook.data.FacebookData;
	import com.facebook.errors.FacebookError;
	
	import flash.events.Event;

	public class FacebookEvent extends Event {
		
		public static const COMPLETE:String = 'complete';
		public static const WAITING_FOR_LOGIN:String = "waitingForLogin";
		public static const VERIFYING_SESSION:String = "verifyingSession";
		public static const CONNECT:String = "connect";
		
		/**
		 * Public access for data returned from the Facebook API. 
		 * 
		 */
		public var success:Boolean;
		public var data:FacebookData;
		public var error:FacebookError;
		
		public function FacebookEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, success:Boolean = false, data:FacebookData = null, error:FacebookError = null) {
			this.success = success;
			this.data = data;
			this.error = error;
			
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new FacebookEvent(type, bubbles, cancelable, success, data, error);
		}
		
		override public function toString():String {
			return formatToString('FacebookEvent', 'type', 'success', 'data', 'error');
		}
		
	}
}