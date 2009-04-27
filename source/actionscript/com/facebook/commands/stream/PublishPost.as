package com.facebook.commands.stream {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.data.feed.ActionLinkCollection;
	import com.facebook.data.feed.TemplateData;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	
	use namespace facebook_internal;

	public class PublishPost extends FacebookCall {
		
		public static const METHOD_NAME:String = 'stream.publish';
		public static const SCHEMA:Array = ['message', 'body', 'story_data', 'section_links'];
		
		public var message:String
		public var body:String
		public var story_data:TemplateData
		public var section_links:ActionLinkCollection
		
		public function PublishPost(message:String, body:String, story_data:TemplateData, section_links:ActionLinkCollection = null) {
			super(METHOD_NAME);
			
			this.message = message;
			this.body = body;
			this.story_data = story_data
			this.section_links = section_links;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, message, body, JSON.encode(story_data), FacebookDataUtils.toJSONValuesArray(section_links.toArray()));
			super.facebook_internal::initialize();
		}
		
	}
}