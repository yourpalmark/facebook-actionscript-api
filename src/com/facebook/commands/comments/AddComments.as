/**
 * http://wiki.developers.facebook.com/index.php/Comments.add
 * September 17, 2009
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
package com.facebook.commands.comments {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The AddComments class represents the public  
      Facebook API known as Comments.add.
	 * @see http://wiki.developers.facebook.com/index.php/Comments.add
	 */
	public class AddComments extends FacebookCall {

		
		public static const METHOD_NAME:String = 'comments.add';
		public static const SCHEMA:Array = ['text','xid','object_id','uid','title','url','publish_to_stream'];
		
		public var text:String;
		public var xid:String;
		public var object_id:String;
		public var uid:String;
		public var title:String;
		public var url:String;
		public var publish_to_stream:Boolean;
		
		public function AddComments(text:String, xid:String = null, object_id:String = null, uid:String = null, title:String = null, url:String = null, publish_to_stream:Boolean = false) {
			super(METHOD_NAME);
			
			if (xid == null && object_id == null) {
				throw new Error("xid or object_id is required");
			}
			
			this.text = text;
			this.xid = xid;
			this.object_id = object_id;
			this.uid = uid;
			this.title = title;
			this.url = url;
			this.publish_to_stream = publish_to_stream;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, text, xid, object_id, uid, title, url, publish_to_stream);
			super.facebook_internal::initialize();
		}
	}
}