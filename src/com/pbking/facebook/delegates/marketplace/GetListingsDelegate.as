package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.marketplace.MarketplaceListing;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetListingsDelegate extends FacebookDelegate
	{
		// VARIABLES //////////
		
		public var listings:Array;
		
		// CONSTRUCTION //////////
		
		function GetListingsDelegate(facebook:Facebook, listingIds:Array=null, users:Array=null)
		{
			super(facebook);
			
			if(listingIds)
				fbCall.setRequestArgument("listing_ids", listingIds.join(","));
			
			if(users)
			{
				var userIds:Array = [];
				for each(var user:FacebookUser in users)
					userIds.push(user.uid);
					
				fbCall.setRequestArgument("uids", userIds.join(","));
			}
			
			fbCall.post("marketplace.getListings");
		}
		
		// RESULT //////////
		
		override protected function handleResult(result:Object):void
		{
			listings = [];
			for each(var listing:Object in result)
			{
				listings.push(new MarketplaceListing(listing));
			}
		}
	}
}