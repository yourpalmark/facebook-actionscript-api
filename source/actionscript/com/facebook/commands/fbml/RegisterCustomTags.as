/**
 * http://wiki.developers.facebook.com/index.php/Fbml.registerCustomTags
 * FEB 23 / 09
 */ 
package com.facebook.commands.fbml {
	
	import com.facebook.data.fbml.TagCollection;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The RegisterCustomTags class represents the public  
      Facebook API known as Fbml.registerCustomTags.
	 * @see http://wiki.developers.facebook.com/index.php/Fbml.registerCustomTags
	 */
	public class RegisterCustomTags extends FacebookCall {

		
		public static const METHOD_NAME:String = 'fbml.registerCustomTags';
		public static const SCHEMA:Array = ['tags'];
		
		public var tags:TagCollection;
		
		public function RegisterCustomTags(tags:TagCollection) {
			super(METHOD_NAME);
			
			this.tags = tags;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.facebookCollectionToJSONArray(tags));
			super.facebook_internal::initialize();
		}
	}
}