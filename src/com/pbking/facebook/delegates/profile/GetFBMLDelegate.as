package com.pbking.facebook.delegates.profile
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	public class GetFBMLDelegate extends FacebookDelegate
	{
		public var markup:String = "";
		public var user:FacebookUser;
		
		public function GetFBMLDelegate(facebook:Facebook, uid:String=null)
		{
			super(facebook);
			
			if(uid)
			{
				fbCall.setRequestArgument("uid", uid);
				user = FacebookUser.getUser(parseInt(uid));
			}
			else
			{
				fbCall.setRequestArgument("uid", facebook.user.uid);
				user = facebook.user;
			}

			fbCall.post("facebook.profile.getFBML");
		}
		
		override protected function handleResult(result:Object):void
		{
			if(result)
				this.markup = result.toString();
		}
		
	}
}