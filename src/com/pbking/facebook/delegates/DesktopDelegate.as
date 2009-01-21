package com.pbking.facebook.delegates
{
	import com.pbking.facebook.session.DesktopSession;
	import com.pbking.facebook.FacebookCall;
	
	public class DesktopDelegate extends WebDelegate
	{

		public function DesktopDelegate(call:FacebookCall, session:DesktopSession)
		{
			super(call, session);
		}
		
		override protected function addOptionalArguments():void
		{
			//no optional arguments to set
			//not calling super because we DON'T what the WebDelegate's
			//arguments to be set.
		}

	}
}