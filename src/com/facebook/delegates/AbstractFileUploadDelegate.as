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
package com.facebook.delegates {
	
	import com.facebook.errors.FacebookError;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.WebSession;
	import com.facebook.utils.PostRequest;
	
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	use namespace facebook_internal;
	
	public class AbstractFileUploadDelegate extends WebDelegate {
		
		protected var ba:ByteArray;
		
		public function AbstractFileUploadDelegate(call:FacebookCall, session:WebSession) {
			super(call, session);
			ba = new ByteArray();
		}
		
		//meant to be overridden in sub classes
		protected function getExt():String { return null; }
		protected function getContentType():String { return null; }
			
		protected function uploadByteArray(bytes:ByteArray):void {			
			var postReq:PostRequest = new PostRequest();
			for (var argIndexName:String in call.args) {
				if (argIndexName != "data") {
					postReq.writePostData(argIndexName, call.args[argIndexName]);
				}
			}
			
			//Add in the data.
			postReq.writeFileData("fn"+call.args['call_id']+"."+getExt(), bytes, getContentType());
			postReq.close();
			
			var urlreq:URLRequest = new URLRequest();
			urlreq.method = URLRequestMethod.POST;
			urlreq.contentType = "multipart/form-data; boundary="+postReq.boundary;
			urlreq.data = postReq.getPostData();
			urlreq.url = _session.rest_url;
			
			createURLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.load(urlreq);
		}
		
		protected function onFileRefComplete(p_event:Event):void {
			fileRef = call.args.data as FileReference;
			uploadByteArray(fileRef['data']);
		}
		
		override protected function onDataComplete(p_event:Event):void {
			var ba:ByteArray = p_event.target.data as ByteArray;
			if (ba == null) { 
				super.onDataComplete(p_event);
			} else {
				var result:String = ba.readUTFBytes(ba.length);
				ba.length = 0;
				ba = null;
				handleResult(result);
			}
		}
	}
}