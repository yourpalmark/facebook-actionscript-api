package com.pbking.facebook.commands.pages
{
	import com.pbking.facebook.FacebookCall;

	[Bindable]	
	public class IsAppAdded extends FacebookCall
	{
		public var page_id:String;
		
		function IsAppAdded(page_id:String=null)
		{
			super("facebook.pages.isAppAdded");
			
			this.page_id = page_id;
		}
		
		override public function initialize():void
		{
			setRequestArgument("page_id", page_id);
		}
	}
}