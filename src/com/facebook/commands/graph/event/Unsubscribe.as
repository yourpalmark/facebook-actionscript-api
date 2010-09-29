package com.facebook.commands.graph.event
{
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	public class Unsubscribe extends FacebookCall
	{
		public static const CORE_METHOD_NAME:String = "Event.unsubscribe";
		public static const SCHEMA:Array = [ 'event' ];
		
		public var event:String;
		
		public function Unsubscribe( event:String=null )
		{
			super();
			coreMethod = CORE_METHOD_NAME;
			
			this.event = event;
		}
		
		override facebook_internal function initialize():void
		{
			applySchema( SCHEMA, event );
			
			super.facebook_internal::initialize();
		}
		
	}
}