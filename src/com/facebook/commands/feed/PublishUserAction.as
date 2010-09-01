/**
 * http://wiki.developers.facebook.com/index.php/Feed.publishUserAction
 * March 12, 2009
 * updated: March 20.09
 * added: user_message parameter;
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

	/**
	 * The PublishUserAction class represents the public  
      Facebook API known as Feed.publishUserAction.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Feed.publishUserAction
	 */
	public class PublishUserAction extends FacebookCall {

		
		public static const METHOD_NAME:String = 'feed.publishUserAction';
		public static const SCHEMA:Array = ['template_bundle_id', 'template_data', 'target_ids', 'body_general', 'story_size', 'user_message'];
		
		public var template_bundle_id:String;
		public var template_data:Object;
		public var target_ids:Array;
		public var body_general:String;
		
		/**
		 * @see com.facebook.data.feed.StorySizeValues;
		 * 
		 */
		public var story_size:Number;
		public var user_message:String;
		
		public function PublishUserAction(template_bundle_id:String, template_data:Object, target_ids:Array=null, body_general:String= null, story_size:Number=NaN, user_message:String = null) {
			super(METHOD_NAME);
			
			this.template_bundle_id = template_bundle_id
			this.template_data = template_data;
			this.target_ids = target_ids;
			this.body_general = body_general;
			this.story_size = story_size;
			this.user_message = user_message;
			
			applySchema(SCHEMA, template_bundle_id, JSON.encode(template_data), FacebookDataUtils.toArrayString(target_ids), body_general, story_size, user_message);
		}
		
	}
}