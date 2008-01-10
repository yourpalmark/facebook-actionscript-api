package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.marketplace.MarketplaceListing;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class CreateListing_delegate extends FacebookDelegate
	{
		public var listing:MarketplaceListing;
		
		function CreateListing_delegate(listing:MarketplaceListing, show_on_profile:Boolean=true)
		{
			this.listing = listing;
			
			fbCall.setRequestArgument("listing_id", listing.listing_id.toString());
			fbCall.setRequestArgument("show_on_profile", show_on_profile.toString());
			
			fbCall.post("marketplace.createListing");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			listing.listing_id = parseInt(resultXML.toString());
		}
	}
}