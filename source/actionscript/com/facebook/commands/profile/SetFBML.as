package com.facebook.commands.profile {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The SetFBML class represents the public  
      Facebook API known as Profile.setFBML.
	 * @see http://wiki.developers.facebook.com/index.php/Profile.setFBML
	 */
	public class SetFBML extends FacebookCall {

		
		public static var METHOD_NAME:String = 'profile.setFBML';
		public static var SCHEMA:Array = ['markup','uid','profile','mobile_profile','profile_main'];
		
		public var markup:String;
		public var uid:String;
		public var profile:String;
		public var mobile_profile:String;
		public var profile_main:String;
		
		public function SetFBML(markup:String=null, uid:String=null, profile:String=null, mobile_profile:String=null, profile_main:String=null) {
			super(METHOD_NAME);
			
			this.markup = markup;
			this.uid = uid;
			this.profile = profile;
			this.mobile_profile = mobile_profile;
			this.profile_main = profile_main;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, markup, uid, profile, mobile_profile, profile_main);
			super.facebook_internal::initialize();
		}
	}
}