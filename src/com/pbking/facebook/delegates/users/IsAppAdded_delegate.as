package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	import flash.events.Event;
	
	public class IsAppAdded_delegate extends FacebookDelegate
	{
		public var pageId:int;
		public var isAdded:Boolean;
		
		public function IsAppAdded_delegate()
		{
			Facebook.instance.logHack("checking if user has added app");
			
			fbCall.setRequestArgument("page_id", pageId.toString());
			fbCall.post("facebook.users.isAppAdded");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;

			isAdded	= parseInt(resultXML.toString()) == 1;
		}
		
	}
}