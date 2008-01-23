package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class SetStatus_delegate extends FacebookDelegate
	{
		public function SetStatus_delegate(status:String, clear:Boolean=false)
		{
			PBLogger.getLogger("pbking.facebook").debug("setting status");
			
			if(clear)
				fbCall.setRequestArgument("clear", "true");
			else
				fbCall.setRequestArgument("status", status);

			fbCall.post("facebook.users.setStatus");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			success = parseInt(resultXML.toString()) == 1;
		}
		
	}
}