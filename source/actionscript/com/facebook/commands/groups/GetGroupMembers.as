/**
 * http://wiki.developers.facebook.com/index.php/Groups.getMembers
 * Feb 10/09 
 */
package com.facebook.commands.groups {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The GetGroupMembers class represents the public  
      Facebook API known as Groups.getMembers.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Groups.getMembers
	 */
	public class GetGroupMembers extends FacebookCall {

		
		public static var METHOD_NAME:String = 'groups.getMembers';
		public static var SCHEMA:Array = ['gid'];
		
		public var gid:String;
		
		public function GetGroupMembers(gid:String) {
			super(METHOD_NAME);
			
			this.gid = gid;
		}
		
		override facebook_internal function initialize():void {			applySchema(SCHEMA, gid);			super.facebook_internal::initialize();		}	
	}
}