package com.pbking.facebook.commands.marketplace
{
	import com.pbking.facebook.FacebookCall;

	[Bindable]
	public class GetCategories extends FacebookCall
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