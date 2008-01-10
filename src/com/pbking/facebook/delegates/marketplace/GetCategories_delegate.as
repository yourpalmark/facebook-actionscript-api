package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetCategories_delegate extends FacebookDelegate
	{
		public var categories:Array;
		
		function GetCategories_delegate()
		{
			fbCall.post("marketplace.getCategories");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
				
			categories = [];
			for each(var catName:XML in resultXML..marketplace_category)
			{
				categories.push( catName.toString() );
			}
		}
	}
}