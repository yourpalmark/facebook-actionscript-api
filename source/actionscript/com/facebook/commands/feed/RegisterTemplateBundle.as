/**
 * http://wiki.developers.facebook.com/index.php/Feed.registerTemplateBundle
 * Feb 20/09
 */ 
package com.facebook.commands.feed {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.data.feed.ActionLinkCollection;
	import com.facebook.data.feed.TemplateCollection;
	import com.facebook.data.feed.TemplateData;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The RegisterTemplateBundle class represents the public  
      Facebook API known as Feed.registerTemplateBundle.
	 * @see http://wiki.developers.facebook.com/index.php/Feed.registerTemplateBundle
	 */
	public class RegisterTemplateBundle extends FacebookCall {

		
		public static const METHOD_NAME:String = 'feed.registerTemplateBundle';
		public static const SCHEMA:Array = ['one_line_story_templates', 'short_story_templates' ,'full_story_template', 'action_links'];
		
		public var one_line_story_templates:Array;
		public var short_story_templates:TemplateCollection;
		public var full_story_template:TemplateData;
		public var action_links:ActionLinkCollection;
		
		public function RegisterTemplateBundle(one_line_story_templates:Array, short_story_templates:TemplateCollection, full_story_template:TemplateData, action_links:ActionLinkCollection) {
			super(METHOD_NAME);
			
			this.one_line_story_templates = one_line_story_templates;
			this.short_story_templates = short_story_templates;
			this.full_story_template = full_story_template;
			this.action_links = action_links;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, JSON.encode(one_line_story_templates), FacebookDataUtils.facebookCollectionToJSONArray(short_story_templates), JSON.encode(full_story_template), FacebookDataUtils.facebookCollectionToJSONArray(action_links));
			super.facebook_internal::initialize();
		}
		
	}
}