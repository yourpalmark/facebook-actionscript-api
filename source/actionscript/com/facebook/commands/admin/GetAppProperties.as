/**
 *http://wiki.developers.facebook.com/index.php/Admin.getAppProperties
 *Feb 16/09
 * ERROR: Unknown method
 */
package com.facebook.commands.admin {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	
	use namespace facebook_internal;

	/**
	 * The GetAppProperties class represents the public  
      Facebook API known as Admin.getAppProperties.
	 * @see http://wiki.developers.facebook.com/index.php/Admin.getAppProperties
	 */
	public class GetAppProperties extends FacebookCall {

		
		public static const METHOD_NAME:String = 'admin.getAppProperties';
		public static const SCHEMA:Array = ['properties'];
		
		public var properties:Array;
		
		public function GetAppProperties(properties:Array) {
			super(METHOD_NAME);
			
			this.properties = properties;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(this.properties));
			super.facebook_internal::initialize();
		}
	}
}