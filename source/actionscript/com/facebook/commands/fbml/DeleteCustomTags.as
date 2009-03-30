/**
 * http://wiki.developers.facebook.com/index.php/Fbml.deleteCustomTags
 * FEB 23/09
 */
package com.facebook.commands.fbml {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The DeleteCustomTags class represents the public  
      Facebook API known as Fbml.deleteCustomTags.
	 * @see http://wiki.developers.facebook.com/index.php/Fbml.deleteCustomTags
	 */
	public class DeleteCustomTags extends FacebookCall {

		
		public static const METHOD_NAME:String = 'fbml.deleteCustomTags';
		public static const SCHEMA:Array = ['names'];
		
		public var names:Array;
		
		public function DeleteCustomTags(names:Array = null) {
			super(METHOD_NAME);
			
			this.names = names;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toJSONValuesArray(names));
			super.facebook_internal::initialize();
		}
	}
}