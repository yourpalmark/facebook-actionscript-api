package com.pbking.facebook.delegates.pages
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class IsAppAddedDelegate extends FacebookDelegate
	{
		function IsAppAddedDelegate(facebook:Facebook, page_id:Number)
		{
			super(facebook);
			
			fbCall.setRequestArgument("page_id", page_id);
			fbCall.post("facebook.pages.isAppAdded");
		}
	}
}