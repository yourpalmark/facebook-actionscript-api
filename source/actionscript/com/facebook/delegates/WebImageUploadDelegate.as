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
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.net.IUploadPhoto;
	import com.facebook.session.WebSession;
	import com.facebook.utils.PlayerUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	use namespace facebook_internal; 
	
	public class WebImageUploadDelegate extends AbstractFileUploadDelegate {
		
		public function WebImageUploadDelegate(call:FacebookCall, session:WebSession) {
			super(call, session);
		}
		
		override protected function getExt() : String { 
			return (call as IUploadPhoto).uploadType == UploadPhotoTypes.JPEG ? 'jpeg' : 'png';
		}
		
		override protected function getContentType() : String {
			return 'Content-Type: image/jpg';
		}
		
		override protected function sendRequest():void {
			var data:ByteArray;
			var urlReq:URLRequest = new URLRequest(_session.rest_url);
			var imageData:Object = call.args.data;
			
			if (imageData == null) {
				super.sendRequest(); //default to WebDelegate sendRequest() if there is no image data; support for optional images such as CreateEvent command
				return;
			}
			
			if (PlayerUtils.majorVersion == 9 && imageData is FileReference) {
				throw new TypeError('Uploading FileReference with Player 9 is unsupported.  Use either an BitmapData or ByteArray.');
			}
			
			if (imageData is Bitmap) { imageData = (imageData as Bitmap).bitmapData; }			
			if (PlayerUtils.majorVersion == 10 && imageData is FileReference) {
				//When using player 10 and FileReference we can just grab the raw ByteArray data from it.
				data = (imageData as FileReference)['load'](); //Bracket access so this complies in Flash 9.
				fileRef = imageData as FileReference;
				fileRef.addEventListener(Event.COMPLETE, onFileRefComplete);
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
	}
}