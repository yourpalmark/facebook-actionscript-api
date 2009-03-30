/**
 * http://wiki.developers.facebook.com/index.php/Admin.getRestrictionInfo
 * Feb 16/09
 */ 
package com.facebook.commands.admin {
	
	import com.facebook.net.FacebookCall;

	/**
	 * The GetRestrictionInfo class represents the public  
      Facebook API known as Admin.getRestrictionInfo.
	 * @see http://wiki.developers.facebook.com/index.php/Admin.getRestrictionInfo
	 */
	public class GetRestrictionInfo extends FacebookCall {

		
		public static var METHOD_NAME:String = 'admin.getRestrictionInfo';
		public static var SCHEMA:Array = [];
		
		public function GetRestrictionInfo() {
			super(METHOD_NAME);
		}
	}
}