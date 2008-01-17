package com.pbking.facebook.delegates.profile
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	public class GetFBML_delegate extends FacebookDelegate
	{
		public var markup:String;
		public var user:FacebookUser;
		
		public function GetFBML_delegate(user:FacebookUser=null)
		{
			Facebook.instance.logHack("getting fbml");
			
			if(user)
				fbCall.setRequestArgument("uid", user.uid.toString());

			fbCall.post("facebook.profile.getFBML");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			this.markup = resultXML.toString();
		}
		
	}
}