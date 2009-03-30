package com.facebook.commands.profile {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The GetFBML class represents the public  
      Facebook API known as Profile.getFBML.
	 * @see http://wiki.developers.facebook.com/index.php/Profile.getFBML
	 */
	public class GetFBML extends FacebookCall {

		
		public static var METHOD_NAME:String = 'profile.getFBML';
		public static var SCHEMA:Array = ['uid','type'];
		
		public var uid:String;
		public var type:Number;
		
		/**
		 * @param type @see ProfileTypeValues
		 */
		public function GetFBML(uid:String=null, type:Number=NaN) {
			super(METHOD_NAME);
			
			this.uid = uid;
			this.type = type;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid, type);
			super.facebook_internal::initialize();
		}	
	}
}