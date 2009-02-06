package com.pbking.facebook.commands.profile
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	
	[Bindable]	
	public class GetFBML extends FacebookCall
	{
		public var markup:String = "";
		
		public var uid:String;
		public var type:String;
		
		public function GetFBML(uid:String=null, type:String=null)
		{
			super("facebook.profile.getFBML");
		}
		
		override public function initialize():void
		{
			clearRequestArguments();
			
			if(uid)
				setRequestArgument("uid", uid);
				
			if(type)
				setRequestArgument("type", type);
		}
		
		override protected function handleSuccess(result:Object):void
		{
			if(result)
				this.markup = result.toString();
		}
		
	}
}