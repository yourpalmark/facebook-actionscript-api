package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	public class HasAppPermissionDelegate extends FacebookDelegate
	{
		/**
		 * String identifier for the extended permission that is being checked for. 
		 * Must be one of status_update, create_listing, or photo_upload.
		 */
		public var extendedPermission:String;
		public var hasPermission:Boolean;
		
		public function HasAppPermissionDelegate(facebook:Facebook, extendedPermission:String)
		{
			super(facebook);
			
			this.extendedPermission = extendedPermission;
			
			fbCall.setRequestArgument("ext_perm", extendedPermission);
			fbCall.post("facebook.users.hasAppPermission");
		}
		
		override protected function handleResult(result:Object):void
		{
			hasPermission = Boolean(result);

		}
		
	}
}