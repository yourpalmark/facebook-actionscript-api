package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.marketplace.MarketplaceListing;
	import com.pbking.facebook.data.users.FacebookUser;

	public class GetListings extends FacebookCall
	{
		// VARIABLES //////////
		
		public var listingIds:Array;
		public var users:Array;
		
		public var listings:Array;
		
		// CONSTRUCTION //////////
		
		function GetListings(listingIds:Array=null, users:Array=null)
		{
			super("marketplace.getListings");
			
			this.listingIds = listingIds;
			this.users = users;
		}
		
		override public function initialize():void
		{
			if(listingIds)
				setRequestArgument("listing_ids", listingIds.join(","));
			
			if(users)
			{
				var userIds:Array = [];
				for(var i:int=0; i<users.length; i++
				{
					userIds.push(users[i] is FacebookUser ? users[i].uid : users[i]);
				}
					
				fbCall.setRequestArgument("uids", userIds.join(","));
			}
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