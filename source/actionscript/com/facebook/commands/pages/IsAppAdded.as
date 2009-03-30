/**
 *http://wiki.developers.facebook.com/index.php/Pages.isAppAdded
 *Feb 16/09 
 * Service temporarily unavailable
 */
package com.facebook.commands.pages {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The IsAppAdded class represents the public  
      Facebook API known as Pages.isAppAdded.
	 * @see http://wiki.developers.facebook.com/index.php/Pages.isAppAdded
	 */
	public class IsAppAdded extends FacebookCall {

		
		public static var METHOD_NAME:String = 'pages.isAppAdded';
		public static var SCHEMA:Array = ['page_id'];
		
		public var page_id:String;
		
		public function IsAppAdded(page_id:String=null) {
			super(METHOD_NAME);
			
			this.page_id = page_id;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, page_id);
			super.facebook_internal::initialize();
		}
	}
}