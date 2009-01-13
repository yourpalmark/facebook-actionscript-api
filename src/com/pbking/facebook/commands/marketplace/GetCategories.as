package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetCategories extends FacebookDelegate
	{
		public var categories:Array;
		
		function GetCategories()
		{
			super("marketplace.getCategories");
		}
		
		override protected function handleSuccess(result:Object):void
		{
			categories = [];
			
			for each(var catName:String in result)
			{
				categories.push( catName );
			}
		}
	}
}