/**
 * 
 * http://wiki.developers.facebook.com/index.php/Feed.deactivateTemplateBundleByID
 * Feb 20/09
 */ 
package com.facebook.commands.feed {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The DeactivateTemplateBundleByID class represents the public  
      Facebook API known as Feed.deactivateTemplateBundleByID.
	 * @see http://wiki.developers.facebook.com/index.php/Feed.deactivateTemplateBundleByID
	 */
	public class DeactivateTemplateBundleByID extends FacebookCall {

		
		public static const METHOD_NAME:String = 'feed.deactivateTemplateBundleByID';
		public static const SCHEMA:Array = ['template_bundle_id'];
		
		public var template_bundle_id:String;
		
		public function DeactivateTemplateBundleByID(template_bundle_id:String) {
			super(METHOD_NAME);
			
			this.template_bundle_id = template_bundle_id;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, template_bundle_id);
			super.facebook_internal::initialize();
		}
	}
}