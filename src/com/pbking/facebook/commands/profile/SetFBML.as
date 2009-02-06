package com.pbking.facebook.commands.profile
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	
	[Bindable]	
	public class SetFBML extends FacebookCall
	{
		public var markup:String;
		public var uid:String;
		
		public function SetFBML(markup:String=null, uid:String=null)
		{
			super("facebook.profile.setFBML");
			
			this.markup = markup;
			this.uid = uid;
		}
		
		override public function initialize():void
		{
			clearRequestArguments();
			
			if(uid)
				setRequestArgument("uid", uid);
			
			setRequestArgument("markup", markup);
		}
	}
}