package com.pbking.facebook.delegates.profile
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	public class SetFBMLDelegate extends FacebookDelegate
	{
		public var markup:String;
		public var user:FacebookUser;
		
		public function SetFBMLDelegate(facebook:Facebook, markup:String, user:FacebookUser=null)
		{
			super(facebook);
			
			this.markup = markup;
			this.user = user;
			
			fbCall.setRequestArgument("markup", markup);
			
			if(user)
				fbCall.setRequestArgument("uid", user.uid.toString());
			
			fbCall.post("facebook.profile.setFBML");
		}

		//since the only result is a success/failure there is no handleResult method		
	}
}