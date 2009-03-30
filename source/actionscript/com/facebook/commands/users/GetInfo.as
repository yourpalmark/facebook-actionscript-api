package com.facebook.commands.users {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The GetInfo class represents the public  
      Facebook API known as Users.getInfo.
	 * @see http://wiki.developers.facebook.com/index.php/Users.getInfo
	 */
	public class GetInfo extends FacebookCall {

		
		public static var METHOD_NAME:String = 'users.getInfo';
		public static var SCHEMA:Array = ['uids', 'fields'];
		
		public var uids:Array;
		public var fields:Array;
		
		public function GetInfo(uids:Array, fields:Array) {
			super(METHOD_NAME);
			
			this.uids = uids;
			this.fields = fields;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(uids), FacebookDataUtils.toArrayString(fields));
			super.facebook_internal::initialize();
		}
	}
}