package com.pbking.facebook.delegates.profile
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	
	public class GetFBML extends FacebookCall
	{
		public var markup:String = "";
		
		public var uid:String;
		public var type:int;
		
		public function GetFBML(uid:String=null, type:int)
		{
			super("facebook.profile.getFBML");
		}
		
		override public function initialize():void
		{
			clearRequestArguments();
			
			if(uid)
				setRequestArgument("uid", uid);
				
			if(type)
				setRequestArgument("type", type.toString());
		}
		
		override protected function handleSuccess(result:Object):void
		{
			if(result)
				this.markup = result.toString();
		}
		
	}
}