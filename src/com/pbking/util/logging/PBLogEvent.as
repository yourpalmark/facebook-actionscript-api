package com.pbking.util.logging
{
	import flash.events.Event;

	public class PBLogEvent extends Event
	{
		public static const LOG:String = "log";
		
		public var message:String;
		public var level:int;
		public var category:String;
		
		function PBLogEvent(message:String, level:int, category:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.message = message;
			this.level = level;
			this.category = category;
			
			super(LOG, bubbles, cancelable)
		}
	}
}