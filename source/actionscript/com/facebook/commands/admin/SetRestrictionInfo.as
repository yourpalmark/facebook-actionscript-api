package com.facebook.commands.admin {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;

	/**
	 * The SetRestrictionInfo class represents the public  
      Facebook API known as Admin.setRestrictionInfo.
	 * @see http://wiki.developers.facebook.com/index.php/Admin.setRestrictionInfo
	 */
	public class SetRestrictionInfo extends FacebookCall {

		
		public static const METHOD_NAME:String = 'admin.setRestrictionInfo';
		public static const SCHEMA:Array = ['restriction_str'];
		
		public var restriction_str:String;
		
		public function SetRestrictionInfo(restriction_str:String='') {
			super(METHOD_NAME);
			
			this.restriction_str = restriction_str;
		}
		
		override facebook_internal function initialize():void {
			this.applySchema(SCHEMA, restriction_str);
			super.facebook_internal::initialize();
		}
	}
}