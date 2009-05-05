/**
 * http://wiki.developers.facebook.com/index.php/Feed.registerTemplateBundle
 * Feb 20/09
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