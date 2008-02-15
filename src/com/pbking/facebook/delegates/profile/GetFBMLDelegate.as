package com.pbking.facebook.delegates.profile
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	public class GetFBMLDelegate extends FacebookDelegate
	{
		public var markup:String;
		public var user:FacebookUser;
		
		public function GetFBMLDelegate(facebook:Facebook, user:FacebookUser=null)
		{
			super(facebook);
			
			if(user)
				fbCall.setRequestArgument("uid", user.uid.toString());

			fbCall.post("facebook.profile.getFBML");
		}
		
		override protected function handleResult(result:Object):void
		{
			this.markup = result.toString();
		}
		
	}
}