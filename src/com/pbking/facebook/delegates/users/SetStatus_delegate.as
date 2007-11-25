package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	import flash.events.Event;
	
	import mx.logging.Log;

	public class SetStatus_delegate extends FacebookDelegate
	{
		public function SetStatus_delegate(fBook:Facebook, status:String, clear:Boolean=false)
		{
			super(fBook);
			Log.getLogger("pbking.facebook").debug("setting status");
			
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