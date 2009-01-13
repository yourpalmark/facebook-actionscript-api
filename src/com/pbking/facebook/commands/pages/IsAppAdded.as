package com.pbking.facebook.delegates.pages
{
	import com.pbking.facebook.FacebookCall;

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