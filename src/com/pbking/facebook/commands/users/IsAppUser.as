package com.pbking.facebook.commands.users
{
	import com.pbking.facebook.FacebookCall;
	
	[Bindable]	
	public class IsAppUser extends FacebookCall
	{
		public var uid:String;
		public var isUser:Boolean;
		
		public function IsAppUser(uid:String=null)
		{
			super("facebook.users.isAppAdded");

			this.uid = uid;
		}
		
		override public function initialize():void
		{
			clearRequestArguments();

			if(uid)
				setRequestArgument("uid", uid);
		}
		
		override protected function handleSuccess(result:Object):void
		{
			isUser	= Boolean(result);
		}
		
	}
}