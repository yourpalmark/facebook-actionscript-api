package com.pbking.facebook.data.pages
{
	import flash.events.EventDispatcher;

	public dynamic class FacebookPage extends EventDispatcher
	{
		public var page_id:Number;
		
		function FacebookPage(initObj:Object=null)
		{
			if(initObj)
			{
				for (var s:String in initObj)
				{
					this[s] = initObj[s];
				}
			}
		}
	}
}