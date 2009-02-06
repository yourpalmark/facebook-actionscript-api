package com.pbking.facebook.commands.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.marketplace.MarketplaceListing;
	
	[Bindable]
	public class SearchListings extends FacebookCall
	{
		// VARIABLES //////////
		
		public var category:String;
		public var subcategory:String;
		public var query:String;
		
		public var listings:Array;
		
		// CONSTRUCTION /////////
		
		function SearchListings(category:String=null, subcategory:String=null, query:String=null)
		{
			super("marketplace.search");
			
			this.category = category;
			this.subcategory = subcategory;
			this.query = query;
		}
		
		override public function initialize():void
		{
			clearRequestArguments();
			
			if(category)
			{
				setRequestArgument("category", category);
				
				if(subcategory)
					setRequestArgument("subcategory", subcategory);
			}
			
			if(query)
				setRequestArgument("query", query);
		}

		// RESULT //////////
		
		override protected function handleSuccess(result:Object):void
		{
			listings = [];
			
			for each(var listing:Object in result)
			{
				listings.push(new MarketplaceListing(listing));
			}
		}
	}
}