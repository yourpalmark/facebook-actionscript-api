/**
 * http://wiki.developers.facebook.com/index.php/Feed.publishTemplatizedAction
 * Feb 10/09
 */ 
package com.facebook.commands.feed {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The PublishTemplatizedAction class represents the public  
      Facebook API known as Feed.publishTemplatizedAction.
	 * @see http://wiki.developers.facebook.com/index.php/Feed.publishTemplatizedAction
	 */
	public class PublishTemplatizedAction extends FacebookCall {

		
		public static var METHOD_NAME:String = 'feed.publishTemplatizedAction';
		public static var SCHEMA:Array = ['title_template', 'title_data', 'body_template', 'body_data', 'body_general', 'page_actor_id', 'image_1', 'image_1_link', 'image_2', 'image_2_link', 'image_3', 'image_3_link', 'image_4', 'image_4_link', 'target_ids'];
		
		public var title_template:String;
		public var title_data:Object;
		
		public var body_template:String;
		public var body_data:Object;
		public var body_general:String; 
		public var page_actor_id:String; 
		
		public var image_1:String;
		public var image_1_link:String;
		
		public var image_2:String;
		public var image_2_link:String; 
		
		public var image_3:String;
		public var image_3_link:String;
		
		public var image_4:String;
		public var image_4_link:String;
		
		public var target_ids:Array;
		
		public function PublishTemplatizedAction(title_template:String, title_data:Object = null, body_template:String = "", body_data:String = "", body_general:String = "", page_actor_id:String="", image_1:String = "", image_1_link:String = "", image_2:String = "", image_2_link:String = "", image_3:String = "", image_3_link:String = "", image_4:String = "",image_4_link:String = "", target_ids:Array=null) {
			super(METHOD_NAME);
			
			this.title_template = title_template;
		    this.title_data = title_data;
		    
			this.body_template = body_template;
			this.body_data= body_data;
			this.body_general = body_general;
			
			this.page_actor_id = page_actor_id;
			
			this.image_1 = image_1; 
			this.image_1_link = image_1_link;
			
			this.image_2 = image_2;
			this.image_2_link= image_2_link;
			
			this.image_3 = image_3;
			this.image_3_link = image_3_link;
			
			this.image_4 = image_4;
			this.image_4_link = image_4_link;
			
			this.target_ids = target_ids;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, title_template, JSON.encode(title_data), body_template, body_data, body_general, page_actor_id, image_1, image_1_link, image_2, image_2_link, image_3, image_3_link, image_4, image_4_link, FacebookDataUtils.toArrayString(target_ids));
			super.facebook_internal::initialize();
		}
	}
}