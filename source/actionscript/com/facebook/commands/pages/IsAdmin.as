/**
 * http://wiki.developers.facebook.com/index.php/Pages.isAdmin
 * Feb 10/09
 */
package com.facebook.commands.pages {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The IsAdmin class represents the public  
      Facebook API known as Pages.isAdmin.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Pages.isAdmin
	 */
	public class IsAdmin extends FacebookCall {

		
		public static const METHOD_NAME:String = 'pages.isAdmin';
		public static const SCHEMA:Array = ['page_id', 'uid'];
		
		public var page_id:String;
		public var uid:String;
		
		public function IsAdmin(page_id:String, uid:String = null) {
			super(METHOD_NAME);
			
			this.page_id = page_id;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, page_id, uid);
			super.facebook_internal::initialize();
		}
	}
}