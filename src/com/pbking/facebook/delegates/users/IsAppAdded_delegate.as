package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	import flash.events.Event;
	
	import mx.logging.Log;

	public class IsAppAdded_delegate extends FacebookDelegate
	{
		public var pageId:int;
		public var isAdded:Boolean;
		
		public function IsAppAdded_delegate(fBook:Facebook, pageId:int)
		{
			super(fBook);
			Log.getLogger("pbking.facebook").debug("checking if page is added to app");
			
			var fbCall:FacebookCall = new FacebookCall(fBook);
			fbCall.setRequestArgument("page_id", pageId.toString());
			fbCall.addEventListener(Event.COMPLETE, result);
			fbCall.post("facebook.pages.isAppAdded");
		}
		
		override protected function result(event:Event):void
		{
			var fbCall:FacebookCall = event.target as FacebookCall;

			default xml namespace = fBook.FACEBOOK_NAMESPACE;

			isAdded	= parseInt(fbCall.getResponse().toString()) == 1;
			
			onComplete();
		}
		
	}
}