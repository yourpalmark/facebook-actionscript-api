package com.facebook.graph.data.ui.credits
{
	public class Credits
	{
		/**
		 * A user-defined value that will get passed to your callback URL set in your application settings.
		 */
		public var order_info:String;
		
		/**
		 * The purchase type.
		 */
		public var purchase_type:String;
		
		/**
		 * Set to true if the user is purchasing credits and not an item.
		 */
		public var credits_purchase:Boolean;
		
		/**
		 * An object for additional params. Used for completing offers.
		 */
		public var dev_purchase_params:Object;
		
		public function Credits()
		{
		}
		
		public function toObject():Object
		{
			var object:Object = {};
			if( order_info ) object.order_info = order_info;
			if( purchase_type ) object.purchase_type = purchase_type;
			if( credits_purchase ) object.credits_purchase = credits_purchase;
			if( dev_purchase_params ) object.dev_purchase_params = dev_purchase_params;
			return object;
		}
		
	}
}