package com.pbking.facebook.delegates.pages
{
	import com.pbking.facebook.FacebookCall;

	public class IsAdmin extends FacebookCall
	{
		public var page_id:String;
		
		function IsAdmin(page_id:Number)
		{
			super("facebook.pages.isAdmin");
			
			this.page_id = page_id;
		}
		
		override public function initialize():void
		{
			setRequestArgument("page_id", page_id);
		}
	}
}