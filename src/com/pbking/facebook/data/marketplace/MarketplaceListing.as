package com.pbking.facebook.data.marketplace
{
	import com.pbking.facebook.data.users.FacebookUser;
	import com.adobe.serialization.json.JSON;
	import flash.events.EventDispatcher;
	
	[Bindable]
	public dynamic class MarketplaceListing extends EventDispatcher
	{
		public var listing_id:Number;
		public var url:String;
		public var poster:FacebookUser;
		public var images:Array;
		public var update_time:Date;

		//common
		public var category:String;
		public var subcategory:String;
		public var title:String;
		public var description:String;

		function MarketplaceListing(initObj:Object)
		{
			for (var prop:String in initObj)
			{
				this[prop] = initObj[prop];
			}
		}
		
		public function getJSON():String
		{
			return JSON.encode(this);
		}

	}
}