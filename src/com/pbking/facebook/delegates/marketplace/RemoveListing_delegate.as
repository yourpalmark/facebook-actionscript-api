package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class RemoveListing_delegate extends FacebookDelegate
	{
		function RemoveListing_delegate(listing_id:int)
		{
			fbCall.setRequestArgument("listing_id", listing_id.toString());
			fbCall.post("marketplace.removeListing");
		}
	}
}