/**
 * http://wiki.developers.facebook.com/index.php/Photos.addTag
 * Feb 16/09
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
package com.facebook.commands.photos {
	
	import com.facebook.data.photos.PhotoTagCollection;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;

	use namespace facebook_internal;

	/**
	 * The AddTag class represents the public  
      Facebook API known as Photos.addTag.
	 * @see http://wiki.developers.facebook.com/index.php/Photos.addTag
	 */
	public class AddTag extends FacebookCall {

		
		public static const METHOD_NAME:String = 'photos.addTag';
		public static const SCHEMA:Array = ['pid','tag_uid','tag_text','x','y','tags','owner_uid'];
		
		public var pid:String;
		public var tag_uid:String;
		public var tag_text:String;
		public var xPos:Number;
		public var yPos:Number;
		public var tags:PhotoTagCollection;
		public var owner_uid:String;
		
		public function AddTag(pid:String, tag_uid:String=null, tag_text:String=null, x:Number=NaN, y:Number=NaN, tags:PhotoTagCollection=null, owner_uid:String=null) {
			super(METHOD_NAME);
			
			if (tags == null && ((tag_uid == null && tag_text == null) || isNaN(x) || isNaN(y))) {
				throw new Error("Must specify tags:PhotoTagCollection, or else must specify tag_uid or tag_text and both x and y values");
			}
			
			this.pid = pid;
			this.tag_uid = tag_uid;
			this.tag_text = tag_text;
			this.xPos = x;
			this.yPos = y;
			this.tags = tags;
			this.owner_uid = owner_uid;
		}
		
		override facebook_internal function initialize():void {
			
			applySchema(SCHEMA, pid, tag_uid, tag_text, xPos, yPos, FacebookDataUtils.facebookCollectionToJSONArray(tags), owner_uid);
			super.facebook_internal::initialize();
		}
	}
}