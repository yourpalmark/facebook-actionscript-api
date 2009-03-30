/**
 * http://wiki.developers.facebook.com/index.php/Data.setUserPreferences
 * Feb 19/09
 */
package com.facebook.commands.data {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.data.data.NameValueCollection;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The SetUserPreferences class represents the public  
      Facebook API known as Data.setUserPreferences.
	 * @see http://wiki.developers.facebook.com/index.php/Data.setUserPreferences
	 */
	public class SetUserPreferences extends FacebookCall {

		
		public static var METHOD_NAME:String = 'data.setUserPreferences';
		public static var SCHEMA:Array = ['map', 'replace'];
		
		public var map:NameValueCollection;
		public var replace:Boolean;
		
		public function SetUserPreferences(map:NameValueCollection, replace:Boolean) {
			super(METHOD_NAME);
			
			this.map = map;
			this.replace = replace;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toJSONValuesArray(map.toArray()), replace);
			super.facebook_internal::initialize();
		}		
	}
}