package com.pbking.facebook.delegates.marketplace
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetSubCategories_delegate extends FacebookDelegate
	{
		public var subcategories:Array;
		
		function GetSubCategories_delegate(category:String)
		{
			fbCall.setRequestArgument("category", category);
			fbCall.post("marketplace.getSubCategories");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
				
			subcategories = [];
			for each(var subCatName:XML in resultXML..marketplace_subcategory)
			{
				subcategories.push( subCatName.toString() );
			}
		}
	}
}