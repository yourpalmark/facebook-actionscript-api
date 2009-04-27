package com.facebook.delegates {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.session.DesktopSession;
	
	public class DesktopDelegate extends WebDelegate {

		public function DesktopDelegate(call:FacebookCall, session:DesktopSession) {
			
			super(call, session);
		}
		
		override protected function addOptionalArguments():void {
			//no optional arguments to set
			//not calling super because we DON'T what the WebDelegate's
			//arguments to be set.
		}
		
	}
}