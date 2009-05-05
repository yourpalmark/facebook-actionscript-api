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
	
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import com.facebook.commands.photos.UploadPhoto;
	import com.facebook.commands.photos.UploadPhotoTypes;
	import com.facebook.data.FacebookErrorReason;
	import com.facebook.errors.FacebookError;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.WebSession;
	import com.facebook.utils.PlayerUtils;
	import com.facebook.utils.PostRequest;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	use namespace facebook_internal;
	
	public class WebImageUploadDelegate extends WebDelegate {
		
		protected var ba:ByteArray = new ByteArray();
		protected var count:Number=0
		
		public function WebImageUploadDelegate(call:FacebookCall, session:WebSession) {
			super(call, session);
		}
		
		override protected function sendRequest():void {
			var data:ByteArray;
			var urlReq:URLRequest = new URLRequest(_session.rest_url);
			var imageData:Object = call.args.data;
			if (PlayerUtils.majorVersion == 9 && imageData is FileReference) {
				throw new TypeError('Uploading FileReference with Player 9 is unsupported.  Use either an BitmapData or ByteArray.');
			}
			
			if (imageData is Bitmap) { imageData = (imageData as Bitmap).bitmapData; }
			if (PlayerUtils.majorVersion == 10 && imageData is FileReference) {
				//When using player 10 and FileReference we can just grab the raw ByteArray data from it.
				data = (imageData as FileReference)['load'](); //Bracket access so this complies in Flash 9.
				fileRef = imageData as FileReference;
				fileRef.addEventListener(Event.COMPLETE, onImageLoaded);
			} else if (imageData is ByteArray) {
				//If we have a ByteArray, upload in either version.
				uploadByteArray(imageData as ByteArray);
			} else if (imageData is BitmapData) {
				//If we have a BitmapData, create a ByteArray, then upload.				
				switch ((call as UploadPhoto).uploadType) {
					case UploadPhotoTypes.JPEG:
						var jpegEncoder:JPGEncoder = new JPGEncoder((call as UploadPhoto).uploadQuality);
						ba = jpegEncoder.encode(imageData as BitmapData); break;
					case UploadPhotoTypes.PNG:
						ba = PNGEncoder.encode(imageData as BitmapData); break;
				}
				uploadByteArray(ba);
			} else {
				throw new Error('Error data type ' + call.args.data + ' is not supported.  Please use one of the following types:  FileReference, ByteArray, BitmapData or Bitmap.');
			}
		}
		
		protected function uploadByteArray(bytes:ByteArray):void {
			var postReq:PostRequest = new PostRequest();
			for (var argIndexName:String in call.args) {
				if (argIndexName != "data") {
					postReq.writePostData(argIndexName, call.args[argIndexName]);
				}
			}
			
			//Add in the image data.
			var ext:String = (call as UploadPhoto).uploadType == UploadPhotoTypes.JPEG?'jpeg':'png';
			postReq.writeFileData("fn"+call.args['call_id']+"."+ext, bytes); 
			postReq.close();
			
			var urlreq:URLRequest = new URLRequest();
			urlreq.method = URLRequestMethod.POST;
			urlreq.contentType = "multipart/form-data; boundary="+postReq.boundary;
			urlreq.data = postReq.getPostData();
			urlreq.url = _session.rest_url;
			
			createURLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.load(urlreq);
			
			connectTimer.start();
		}
		
		protected function onImageLoaded(p_event:Event):void {
			fileRef = call.args.data as FileReference;
			uploadByteArray(fileRef['data']);
		}
		
		override protected function onDataComplete(p_event:Event):void {
			var ba:ByteArray = p_event.target.data as ByteArray;
			if (ba == null) { //Hopefully should never get here.
				var error:FacebookError = new FacebookError();
				call.handleError(error);
				clean();
			} else {
				var result:String = ba.readUTFBytes(ba.length);
				ba.length = 0;
				ba = null;
				handleResult(result);
			}
		}
	}
}