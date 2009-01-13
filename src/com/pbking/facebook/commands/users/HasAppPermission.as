package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	
	public class HasAppPermission extends FacebookCall
	{
		/**
		 * String identifier for the extended permission that is being checked for. 
		 * Must be one of status_update, create_listing, or photo_upload.
		 */
		public var extendedPermission:String;
		public var hasPermission:Boolean;
		
		public function HasAppPermission(extendedPermission:String=null)
		{
			super("facebook.users.hasAppPermission");
			this.extendedPermission = extendedPermission;
		}
		
		override public function initialize():void
		{
			setRequestArgument("ext_perm", extendedPermission);
		}
		
		override protected function handleSuccess(result:Object):void
		{
			hasPermission = Boolean(result);
		}
		
	}
}