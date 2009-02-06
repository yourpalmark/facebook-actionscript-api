package com.pbking.facebook.commands.pages
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.pages.FacebookPage;

	[Bindable]	
	public class GetPageInfo extends FacebookCall
	{
		public var fields:Array;
		public var page_ids:Array;
		public var uid:String;
		public var type:String;
		
		public var pages:Array;
		
		function GetPageInfo(fields:Array, page_ids:Array=null, uid:String=null, type:String=null)
		{
			super("facebook.pages.getInfo");
			
			this.fields = fields;
			this.page_ids = page_ids;
			this.uid = uid;
			this.type = type;
		}
		
		override public function initialize():void
		{
			clearRequestArguments();
			
			setRequestArgument("fields", fields.join(","));
			
			if(page_ids) 
				setRequestArgument("page_ids", page_ids.join(","));
				
			if(uid) 
				setRequestArgument("uid", uid.toString());
				
			if(type) 
				setRequestArgument("type", type);
		}
		
		override protected function handleSuccess(result:Object):void
		{
			pages = [];
			
			for each(var page:Object in result)
			{
				pages.push(new FacebookPage(page));
			} 
		}
		
	}
}