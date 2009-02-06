package com.pbking.facebook.commands.marketplace
{
	import com.pbking.facebook.FacebookCall;

	[Bindable]
	public class RemoveListing extends FacebookCall
	{
		public var listing_id:String;
		
		function RemoveListing(listing_id:String)
		{
			super("marketplace.removeListing");
			
			this.listing_id = listing_id;
		}
		
		override public function initialize():void
		{
			setRequestArgument("listing_id", listing_id.toString());
		}
	}
}