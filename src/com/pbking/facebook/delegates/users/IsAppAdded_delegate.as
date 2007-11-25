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
			
			fbCall.setRequestArgument("page_id", pageId.toString());
			fbCall.post("facebook.pages.isAppAdded");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;

			isAdded	= parseInt(resultXML.toString()) == 1;
		}
		
	}
}