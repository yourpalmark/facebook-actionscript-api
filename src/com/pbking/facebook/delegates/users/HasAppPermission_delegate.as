package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	import flash.events.Event;
	
	import mx.logging.Log;

	public class HasAppPermission_delegate extends FacebookDelegate
	{
		/**
		 * String identifier for the extended permission that is being checked for. 
		 * Must be one of status_update, create_listing, or photo_upload.
		 */
		public var extendedPermission:String;
		public var hasPermission:Boolean;
		
		public function HasAppPermission_delegate(fBook:Facebook, extendedPermission:String)
		{
			super(fBook);
			Log.getLogger("pbking.facebook").debug("getting extended permission for: " + extendedPermission);
			
			this.extendedPermission = extendedPermission;
			
			var fbCall:FacebookCall = new FacebookCall(fBook);
			fbCall.setRequestArgument("ext_perm", extendedPermission);
			fbCall.addEventListener(Event.COMPLETE, result);
			fbCall.post("facebook.users.hasAppPermission");
		}
		
		override protected function result(event:Event):void
		{
			var fbCall:FacebookCall = event.target as FacebookCall;

			default xml namespace = fBook.FACEBOOK_NAMESPACE;
				
			hasPermission = parseInt(fbCall.getResponse().toString()) == 1;
			
			onComplete();
		}
		
	}
}