/**
 * http://wiki.developers.facebook.com/index.php/Feed.publishTemplatizedAction
 * Feb 10/09
 */ 
/*
  Copyright (c) 2009, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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

		
		public static const METHOD_NAME:String = 'feed.publishTemplatizedAction';
		public static const SCHEMA:Array = ['title_template', 'title_data', 'body_template', 'body_data', 'body_general', 'page_actor_id', 'image_1', 'image_1_link', 'image_2', 'image_2_link', 'image_3', 'image_3_link', 'image_4', 'image_4_link', 'target_ids'];
		
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