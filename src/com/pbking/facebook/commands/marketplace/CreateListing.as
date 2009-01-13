package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.marketplace.MarketplaceListing;

	public class CreateListing extends FacebookCall
	{
		public var listing:MarketplaceListing;
		public var show_on_profile:Boolean = true;
		
		function CreateListing(listing:MarketplaceListing=null, show_on_profile:Boolean=true)
		{
			super("marketplace.createListing");
			
			this.listing = listing;
			this.show_on_profile = show_on_profile;
		}
		
		override public function initialize():void
		{
			setRequestArgument("listing_id", listing.listing_id.toString());
			setRequestArgument("show_on_profile", show_on_profile.toString());
		}
		
		override protected function handleSuccess(result:Object):void
		{
			listing.listing_id = Number(result);
		}
	}
}