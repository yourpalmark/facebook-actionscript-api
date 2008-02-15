package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class IsAppAddedDelegate extends FacebookDelegate
	{
		public var pageId:int;
		public var isAdded:Boolean;
		
		public function IsAppAddedDelegate(facebook:Facebook)
		{
			super(facebook);
			
			fbCall.setRequestArgument("page_id", pageId.toString());
			fbCall.post("facebook.users.isAppAdded");
		}
		
		override protected function handleResult(result:Object):void
		{
			isAdded	= Boolean(result);
		}
		
	}
}