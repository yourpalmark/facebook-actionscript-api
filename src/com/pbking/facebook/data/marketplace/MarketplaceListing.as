package com.pbking.facebook.data.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class MarketplaceListing extends EventDispatcher
	{
		public var listing_id:Number;
		public var url:String;
		public var poster:FacebookUser;
		public var images:Array;
		public var update_time:Date;

		//All
		public var category:String;
		public var subcategory:String;
		public var title:String;
		public var description:String;

		public var properties:Object = new Object();

		function MarketplaceListing(listing_id:int=0)
		{
			this.listing_id = listing_id;
		}
		
		public function getProperty(propertyName:String):String
		{
			return properties[propertyName] as String;
		}
		
		public function getJSON():String
		{
			var JSONProps:Array = [];
			
			JSONProps.push("'category':'" + category + "'");
			JSONProps.push("'subcategory':'" + subcategory + "'");
			JSONProps.push("'title':'" + title + "'");
			JSONProps.push("'description':'" + description + "'");
			
			for (var propName:String in this.properties)
				JSONProps.push("'"+propName+"':'" + properties[propName] + "'");
			
			var JSONString:String = "{" + JSONProps.join(",") + "}";
			
			return JSONString;
		}

		public static function createListingFromXML(listingX:XML):MarketplaceListing
		{
			if(listingX.listing_id == undefined)
				return null;
				
			var newListing:MarketplaceListing = new MarketplaceListing(parseInt(listingX.listing_id));
			
			//common
			if(listingX.url != undefined)
				newListing.url = listingX.url.toString();

			if(listingX.poster != undefined)
				newListing.poster = Facebook.instance.getUser(parseInt(listingX.poster));

			if(listingX.title != undefined)
				newListing.title = listingX.title.toString();
				
			if(listingX.description != undefined)
				newListing.description = listingX.description.toString();

			//uncommon
			var commonProps:Array = ["listing_id", "url", "title", "description", "poster"];			
			for each(var listingPropX:XML in listingX)
			{
				var propName:String = listingPropX.name();
				var uncommon:Boolean = true;
				for each(var commonProp:String in commonProps)
				{
					if(propName == commonProp)
					{
						uncommon = false;
						break;
					}
				}
				if(uncommon)
					newListing.properties[propName] = listingPropX.toString();
			}

			return newListing;
		}

	}
}