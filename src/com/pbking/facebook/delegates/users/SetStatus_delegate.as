package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	import flash.events.Event;
	
	import mx.logging.Log;

	public class SetStatus_delegate extends FacebookDelegate
	{
		public var success:Boolean;
		
		public function SetStatus_delegate(fBook:Facebook, status:String, clear:Boolean=false)
		{
			super(fBook);
			Log.getLogger("pbking.facebook").debug("setting status");
			
			var fbCall:FacebookCall = new FacebookCall(fBook);
			if(clear)
				fbCall.setRequestArgument("clear", "true");
			else
				fbCall.setRequestArgument("status", status);
			fbCall.addEventListener(Event.COMPLETE, result);
			fbCall.post("facebook.friends.get");
		}
		
		override protected function result(event:Event):void
		{
			var fbCall:FacebookCall = event.target as FacebookCall;

			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			success = parseInt(fbCall.getResponse().toString()) == 1;
			
			onComplete();
		}
		
	}
}