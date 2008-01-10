package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.marketplace.MarketplaceListing;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetListings_delegate extends FacebookDelegate
	{
		// VARIABLES //////////
		
		public var listings:Array;
		
		// CONSTRUCTION //////////
		
		function GetListings_delegate(listingIds:Array=null, users:Array=null)
		{
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
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
				
			listings = [];
			for each(var listingX:XML in resultXML..listing)
			{
				listings.push(MarketplaceListing.createListingFromXML(listingX));
			}
		}
	}
}