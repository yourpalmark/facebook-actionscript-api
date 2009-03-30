/**
 * Feb 19/09
 * http://wiki.developers.facebook.com/index.php/Users.getStandardInfo
 */
package com.facebook.commands.users {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetStandardInfo class represents the public  
      Facebook API known as Users.getStandardInfo.
	 * @see http://wiki.developers.facebook.com/index.php/Users.getStandardInfo
	 */
	public class GetStandardInfo extends FacebookCall {

		
		public static var METHOD_NAME:String = 'users.getStandardInfo';
		public static var SCHEMA:Array = ['uids','fields','format'];
		
		public var uids:Array;
		public var fields:Array;
		public var format:String;
		
		public function GetStandardInfo(uids:Array, fields:Array, format:String='') {
			super(METHOD_NAME);
			
			this.uids = uids;
			this.fields = fields;
			this.format = format;
		}
		
		override facebook_internal function initialize():void {
			this.applySchema(SCHEMA, uids, FacebookDataUtils.toArrayString(fields), format);
			super.facebook_internal::initialize();
		}
	}
}