package com.pbking.facebook.delegates.profile
{
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class SetFBML_delegate extends FacebookDelegate
	{
		public var markup:String;
		public var user:FacebookUser;
		
		public function SetFBML_delegate(markup:String, user:FacebookUser=null)
		{
			PBLogger.getLogger("pbking.facebook").debug("setting fbml");
			
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