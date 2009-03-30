package com.facebook.delegates {
	
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import com.facebook.commands.photos.UploadPhoto;
	import com.facebook.commands.photos.UploadPhotoTypes;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.WebSession;
	import com.facebook.utils.PlayerUtils;
	import com.facebook.utils.PostRequest;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;

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
			
			if (imageData is Bitmap) {  imageData = (imageData as Bitmap).bitmapData; }
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
						ba =  PNGEncoder.encode(imageData as BitmapData); break;
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
			postReq.writeFileData("fn"+call.args['call_id']+".jpg", bytes); 
			postReq.close();
			
			var urlreq:URLRequest = new URLRequest();
			urlreq.method = URLRequestMethod.POST;
			urlreq.contentType = "multipart/form-data; boundary="+postReq.boundary;
			urlreq.data = postReq.getPostData();
			urlreq.url = _session.rest_url;
			
			createURLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.load(urlreq);
			
			connectTimer.start()
		}
		
		protected function onImageLoaded(p_event:Event):void {
			fileRef = call.args.data as FileReference;
			uploadByteArray(fileRef['data']);
		}
		
		protected function onUploadComplete(event:DataEvent):void {
			handleResult(event.data);
		}
		
	}
}