package com.pbking.facebook.delegates.profile
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	public class SetFBMLDelegate extends FacebookDelegate
	{
		public var markup:String;
		public var user:FacebookUser;
		
		public function SetFBMLDelegate(facebook:Facebook, markup:String, uid:String=null)
		{
			super(facebook);
			
			this.markup = markup;
			
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

			fbCall.setRequestArgument("markup", markup);
			
			fbCall.post("facebook.profile.setFBML");
		}

		//since the only result is a success/failure there is no handleResult method		
	}
}