/**
 * http://wiki.developers.facebook.com/index.php/Data.getCookies
 * Feb 20/09
 * updated FEB 27/09
 */
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The GetCookies class represents the public  
      Facebook API known as Data.getCookies.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getCookies
	 */
	public class GetCookies extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getCookies';
		public static const SCHEMA:Array = ['uid', 'name'];
		
		public var uid:String;
		public var name:String;
		
		public function GetCookies(uid:String, name:String = null) {
			super(METHOD_NAME);
			
			this.uid = uid;
			this.name = name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid,name);
			super.facebook_internal::initialize();
		}		
	}
}