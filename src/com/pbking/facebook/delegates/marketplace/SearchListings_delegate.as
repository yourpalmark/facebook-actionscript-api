package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.marketplace.MarketplaceListing;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	public class SearchListings_delegate extends FacebookDelegate
	{
		// VARIABLES //////////
		
		public var listings:Array;
		
		// CONSTRUCTION /////////
		
		function SearchListings_delegate(category:String="", subcategory:String="", query:String="")
		{
			if(category != "")
			{
				fbCall.setRequestArgument("category", category);
				if(subcategory != "")
					fbCall.setRequestArgument("subcategory", subcategory);
			}
			
			if(query != "")
				fbCall.setRequestArgument("query", query);
				
			fbCall.post("marketplace.search");
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