package com.pbking.util.logging
{
	import flash.events.Event;

	public class PBLogEvent extends Event
	{
		public var message:String;
		
		function PBLogEvent(message:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super("PBLogEvent", bubbles, cancelable)
		}
	}
}