package com.facebook.commands.users {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The HasAppPermission class represents the public  
      Facebook API known as Users.hasAppPermission.
	 * @see http://wiki.developers.facebook.com/index.php/Users.hasAppPermission
	 */
	public class HasAppPermission extends FacebookCall {

		
		public static const METHOD_NAME:String = 'users.hasAppPermission';
		public static const SCHEMA:Array = ['ext_perm', 'uid'];
		
		public var ext_perm:String;
		public var uid:String;
		
		/**
		 * 
		 * @param ext_perm @see ExtendedPermissionValues
		 */
		public function HasAppPermission(ext_perm:String, uid:String=null) {
			super(METHOD_NAME);
			
			this.ext_perm = ext_perm;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, ext_perm, uid);
			super.facebook_internal::initialize();
		}
	}
}