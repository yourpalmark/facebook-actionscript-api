package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.FacebookCall;
	
	public class SetStatus extends FacebookCall
	{
		public var status:String;
		public var clear:Boolean;
		public var status_includes_verb:Boolean;
		
		public function SetStatus(status:String=null, clear:Boolean=false, status_includes_verb:Boolean=false)
		{
			super("facebook.users.setStatus");
			
			this.status = status;
			this.clear = clear;
			this.status_includes_verb = status_includes_verb;
		}
		
		override public function initialize():void
		{
			clearRequestArguments();
			
			if(clear)
			{
				setRequestArgument("clear", "true");
			}
			else
			{
				setRequestArgument("status", status);
				setRequestArgument("status_includes_verb", status_includes_verb);
			}
		}
	}
}