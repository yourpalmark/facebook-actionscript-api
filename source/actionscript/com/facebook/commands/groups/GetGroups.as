/**
 * http://wiki.developers.facebook.com/index.php/Groups.get
 * Feb 10/09
 */ 
package com.facebook.commands.groups {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The GetGroups class represents the public  
      Facebook API known as Groups.get.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Groups.get
	 */
	public class GetGroups extends FacebookCall {		

		
		public static const METHOD_NAME:String = 'groups.get';
		public static const SCHEMA:Array = ['gids','uid'];
		
		public var gids:Array;
		public var uid:String;
		
		public function GetGroups(gids:Array=null, uid:String=null) {
			super(METHOD_NAME);
			
			this.gids = gids;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(gids), uid);
			super.facebook_internal::initialize();
		}
	}
	
}