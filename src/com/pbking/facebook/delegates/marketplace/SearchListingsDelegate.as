package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.marketplace.MarketplaceListing;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	public class SearchListingsDelegate extends FacebookDelegate
	{
		// VARIABLES //////////
		
		public var listings:Array;
		
		// CONSTRUCTION /////////
		
		function SearchListingsDelegate(facebook:Facebook, category:String="", subcategory:String="", query:String="")
		{
			super(facebook);
			
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