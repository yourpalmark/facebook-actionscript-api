package com.pbking.facebook.events
{
	import flash.events.Event;

	public class FacebookActionEvent extends Event
	{
		public static const WAITING_FOR_LOGIN:String = "waiting_for_login";
		public static const COMPLETE:String = "complete";
		
		public function FacebookActionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}