package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class RemoveListingDelegate extends FacebookDelegate
	{
		function RemoveListingDelegate(facebook:Facebook, listing_id:int)
		{
			super(facebook);
			fbCall.setRequestArgument("listing_id", listing_id.toString());
			fbCall.post("marketplace.removeListing");
		}
	}
}