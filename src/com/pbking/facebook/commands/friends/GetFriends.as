package com.pbking.facebook.commands.friends
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	
	[Bindable]
	public class GetFriends extends FacebookCall
	{
		public var friends:Array;
		public var uid:String;
		
		public function GetFriends(uid:String=null)
		{
			super("facebook.friends.get");

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
			var myFriends:Array = [];
			
			for each(var uid:int in result)
			{
				myFriends.push(FacebookUser.getUser(uid));
			} 
			
			friends = myFriends;
		}
		
	}
}