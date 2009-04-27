package com.facebook.commands.profile {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The ProfileGetInfo class represents the public  
      Facebook API known as Profile.getInfo.
	 * @see http://wiki.developers.facebook.com/index.php/Profile.getInfo
	 */
	public class ProfileGetInfo extends FacebookCall {

		
		public static const METHOD_NAME:String = 'profile.getInfo';
		public static const SCHEMA:Array = ['uid'];
		
		public var uid:String;
		
		public function ProfileGetInfo(uid:String) {
			super(METHOD_NAME);
			
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid);
			super.facebook_internal::initialize();
		}		
	}
}