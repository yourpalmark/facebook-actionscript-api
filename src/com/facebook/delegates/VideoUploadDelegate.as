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
	
	import com.facebook.commands.video.UploadVideo;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.WebSession;
	import com.facebook.utils.PlayerUtils;
	
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	public class VideoUploadDelegate extends AbstractFileUploadDelegate {
		
		public function VideoUploadDelegate(call:FacebookCall, session:WebSession) {
			super(call, session);
		}
		
		override protected function getExt() : String {
			return (call as UploadVideo).ext;
		}
		
		override protected function getContentType() : String {
			return 'Content-Type: video/' + (call as UploadVideo).ext;
		}
		
		override protected function sendRequest():void {
			var data:ByteArray;
			var urlReq:URLRequest = new URLRequest(_session.rest_url);
			var videoData:Object = call.args.data;
			if (PlayerUtils.majorVersion == 9 && videoData is FileReference) {
				throw new TypeError('Uploading FileReference with Player 9 is unsupported.  Use ByteArray.');
			}
			
			if (PlayerUtils.majorVersion == 10 && videoData is FileReference) {
				//When using player 10 and FileReference we can just grab the raw ByteArray data from it.
				data = (videoData as FileReference)['load'](); //Bracket access so this complies in Flash 9.
				fileRef = videoData as FileReference;
				fileRef.addEventListener(Event.COMPLETE, onFileRefComplete);				
			} else if (videoData is ByteArray) {
				//If we have a ByteArray, upload in either version.
				uploadByteArray(videoData as ByteArray);				
			} else {
				throw new Error('Error data type ' + call.args.data + ' is not supported.  Please use one of the following types:  FileReference or ByteArray.');
			}
		}
	}
}