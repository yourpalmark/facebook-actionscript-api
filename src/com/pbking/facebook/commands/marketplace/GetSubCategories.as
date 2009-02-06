package com.pbking.facebook.commands.marketplace
{
	import com.pbking.facebook.FacebookCall;

	[Bindable]
	public class GetSubCategories extends FacebookCall
	{
		public var category:String;
		public var subcategories:Array;
		
		function GetSubCategories(category:String=null)
		{
			super("marketplace.getSubCategories");
			
			this.category = category;
		}
		
		override public function initialize():void
		{
			setRequestArgument("category", category);
		}
		
		override protected function handleSuccess(result:Object):void
		{
			subcategories = [];
			for each(var subCatName:String in result)
			{
				subcategories.push( subCatName );
			}
		}
	}
}