package com.pbking.facebook.events
{
	import flash.events.Event;

	public class FacebookActionEvent extends Event
	{
		public static const WAITING_FOR_LOGIN:String = "waiting_for_login";
		public static const CONNECT:String = "connect";
		public static const CONNECTION_ERROR:String = "connection_error";
		
		public var message:String;
		
		public function FacebookActionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, message:String=null)
		{
			super(type, bubbles, cancelable);
			this.message = message;
		}
		
	}
}