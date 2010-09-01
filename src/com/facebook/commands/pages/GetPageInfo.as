/**
 * http://wiki.developers.facebook.com/index.php/Pages.getInfo
 * Feb 13/09
 * BUG with this API Call
 * Feb 13/09
 * BUG# 4373
 * http://bugs.developers.facebook.com/show_bug.cgi?id=4373
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
package com.facebook.commands.pages {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetPageInfo class represents the public  
      Facebook API known as Pages.getInfo.
	 * @see http://wiki.developers.facebook.com/index.php/Pages.getInfo
	 */
	public class GetPageInfo extends FacebookCall {

		
		public static const METHOD_NAME:String = 'pages.getInfo';
		public static const SCHEMA:Array = ['fields', 'page_ids','uid'];
		
		public var fields:Array;
		public var page_ids:Array;
		public var uid:String;
		
		public function GetPageInfo(fields:Array, page_ids:Array=null, uid:String=null) {
			super(METHOD_NAME);
			
			this.fields = fields;
			this.page_ids = page_ids;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(fields), FacebookDataUtils.toArrayString(page_ids), uid);
			super.facebook_internal::initialize();
		}
	}
}