package com.pbking.facebook.methodGroups
{
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	import flash.events.Event;
	
	public class MethodGroupUtil
	{
		public static function addCallback(delegate:FacebookDelegate, callback:Function):FacebookDelegate
		{
			if(callback != null)
				delegate.addEventListener(Event.COMPLETE, callback);

			return delegate;
		}
	}
}