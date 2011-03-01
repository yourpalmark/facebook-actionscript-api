/*
  Copyright (c) 2010, Adobe Systems Incorporated
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

package com.facebook.graph.net {

    import com.adobe.images.PNGEncoder;
    import com.adobe.serialization.json.JSON;
    import com.facebook.graph.utils.PostRequest;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.DataEvent;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.FileReference;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
    import flash.utils.ByteArray;

    /**
    * Main class to send requests to the Facebook API.
    *
    */
    public class FacebookRequest {

        /**
        * @private
        *
        */
        protected var urlLoader:URLLoader;

        /**
        * @private
        *
        */
        protected var fileReference:FileReference;

        /**
        * @private
        *
        */
        protected var urlRequest:URLRequest;

        /**
        * @private
        *
        */
        protected var _rawResult:String;

        /**
        * @private
        *
        */
        protected var _data:Object;

        /**
        * @private
        *
        */
        protected var _success:Boolean;

        /**
        * @private
        *
        */
        protected var _url:String;

        /**
        * @private
        *
        */
        protected var _requestMethod:String;

        /**
        * @private
        *
        */
        protected var _callback:Function;

        /**
        * Instantiates a new FacebookRequest.
        *
        * @param url The URL to request data from.
        * Usually will be https://graph.facebook.com.
        * @param requestMethod The URLRequestMethod
        * to be used for this request.
        * <ul>
        *	<li>GET for retrieving data (Default)</li>
        * 	<li>POST for publishing data</li>
        * 	<li>DELETE for deleting objects (AIR only)</li>
        * </ul>
    * @param callback Method to call when this request is complete.
    * The signaure of the handler must be callback(request:FacebookRequest);
    * Where request will be a reference to this request.
        */
        public function FacebookRequest(url:String,
                                        requestMethod:String = 'GET',
                                        callback:Function = null
                                        ):void {

            _url = url;
            _requestMethod = requestMethod;
            _callback = callback;
        }

        /**
        * Returns the un-parsed result from Facebook.
        * Usually this will be a JSON formatted string.
        *
        */
        public function get rawResult():String {
            return _rawResult;
        }

        /**
        * Returns true if this request was successful,
        * or false if an error occurred.
        * If success == true, the data property will be the corresponding
        * decoded JSON data returned from facebook.
    *
        * If success == false, the data property will either be the error
        * from Facebook, or the related ErrorEvent.
        *
        */
        public function get success():Boolean {
            return _success;
        }

        /**
        * Any resulting data returned from Facebook.
        * @see #success
        *
        */
        public function get data():Object {
            return _data;
        }
		
		public function callURL(callback:Function, url:String = "", locale:String = null):void {			
			_callback = callback;
			urlRequest = new URLRequest(url.length ? url : _url);
			
			if (locale) {
				var data:URLVariables = new URLVariables();
				data.locale = locale;
				urlRequest.data = data;
			}
			loadURLLoader();
		}

        /**
        * Makes a request to the Facebook Graph API.
        *
        */
        public function call(method:String,
                             values:* = null,
                             callback:Function = null
                             ):void {

            if (callback != null) {
                _callback = callback;
            }
            var requestUrl:String = _url + method;

            urlRequest = new URLRequest(requestUrl);
            urlRequest.method = _requestMethod;

            //If there are no user defined values, just send the request as is.
            if (values == null) {
                loadURLLoader();
                return;
            }

            //Check to see if there is a file we can upload.
            var fileData:Object;
            if (isValueFile(values)) {
                fileData = values;
            } else if (values != null) {
                for (var n:String in values) {
                    if (isValueFile(values[n])) {
                        fileData = values[n];
                        delete values[n];
                        break;
                    }
                }
            }

            //There is no fileData, so just send it off.
            if (fileData == null) {
                urlRequest.data = objectToURLVariables(values);
                loadURLLoader();
                return;
            }

            //If the fileData is a FileReference, let it handle this request.
            if (fileData is FileReference) {
                urlRequest.data = objectToURLVariables(values);
                urlRequest.method = URLRequestMethod.POST;

                fileReference = fileData as FileReference;
                fileReference.addEventListener(
                                            DataEvent.UPLOAD_COMPLETE_DATA,
                                            handleFileReferenceData,
                                            false, 0, true
                                            );

                fileReference.addEventListener(
                                            IOErrorEvent.IO_ERROR,
                                            handelFileReferenceError,
                                            false, 0, false
                                            );

                fileReference.addEventListener(
                                            SecurityErrorEvent.SECURITY_ERROR,
                                            handelFileReferenceError,
                                            false, 0, false
                                            );

                fileReference.upload(urlRequest);
                return;
            }

            //There is fileData attached here, need to format it correctly,
            //then send it to Facebook.
            var post:PostRequest = new PostRequest();

            //Write the primitive values first.
            for (n in values) {
                post.writePostData(n, values[n]);
            }

            //If we have a Bitmap, extract its BitmapData for upload.
            if (fileData is Bitmap) {
                fileData = (fileData as Bitmap).bitmapData;
            }

            if (fileData is ByteArray) {
                //If we have a ByteArray, upload as is.
                post.writeFileData(values.fileName,
                                fileData as ByteArray,
                                values.contentType
                                );

            } else if (fileData is BitmapData) {
                //If we have a BitmapData, create a ByteArray, then upload.
                var ba:ByteArray = PNGEncoder.encode(fileData as BitmapData);
                post.writeFileData(values.fileName, ba, 'image/png');
            }

            post.close();
            urlRequest.contentType =
                    'multipart/form-data; boundary='
                    + post.boundary;

            urlRequest.data = post.getPostData();
            urlRequest.method = URLRequestMethod.POST;

            loadURLLoader();
        }

        protected function isValueFile(value:Object):Boolean {
            return (value is FileReference || value is Bitmap || value is BitmapData || value is ByteArray);
        }

        protected function objectToURLVariables(values:Object):URLVariables {
            var urlVars:URLVariables = new URLVariables();
            if (values == null) {
                return urlVars;
            }

            for (var n:String in values) {
                urlVars[n] = values[n];
            }

            return urlVars;
        }

        /**
        * Cancels the current request.
        *
        */
        public function close():void {
            if (urlLoader != null) {
                urlLoader.removeEventListener(
                                            Event.COMPLETE,
                                            handleURLLoaderComplete
                                            );

                urlLoader.removeEventListener(
                                            IOErrorEvent.IO_ERROR,
                                            handleURLLoaderIOError
                                            );

                urlLoader.removeEventListener(
                                            SecurityErrorEvent.SECURITY_ERROR,
                                            handleURLLoaderSecurityError
                                            );

                try {
                    urlLoader.close();
                } catch (e:*) { }

                urlLoader = null;
            }

            if (fileReference != null) {
                fileReference.removeEventListener(
                                            DataEvent.UPLOAD_COMPLETE_DATA,
                                            handleFileReferenceData
                                            );

                fileReference.removeEventListener(
                                            IOErrorEvent.IO_ERROR,
                                            handelFileReferenceError
                                            );

                fileReference.removeEventListener(
                                            SecurityErrorEvent.SECURITY_ERROR,
                                            handelFileReferenceError
                                            );

                try {
                    fileReference.cancel();
                } catch (e:*) { }

                fileReference = null;
            }
        }

        /**
        * @private
        *
        */
        protected function loadURLLoader():void {
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,
                                    handleURLLoaderComplete,
                                    false, 0, false
                                    );

            urlLoader.addEventListener(IOErrorEvent.IO_ERROR,
                                    handleURLLoaderIOError,
                                    false, 0, true
                                    );

            urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
                                    handleURLLoaderSecurityError,
                                    false, 0, true
                                    );

            urlLoader.load(urlRequest);
        }

        /**
        * @private
        *
        */
        protected function handleURLLoaderComplete(event:Event):void {
            handleDataLoad(urlLoader.data);
        }

        /**
        * @private
        *
        */
        protected function handleDataLoad(result:Object,
                                        dispatchCompleteEvent:Boolean = true
                                        ):void {

            _rawResult = result as String;
            _success = true;

            try {
                _data = JSON.decode(_rawResult);
            } catch (e:*) {
                _data = _rawResult;
                _success = false;
            }

            if (dispatchCompleteEvent) {
                dispatchComplete();
            }
        }

        /**
        * @private
        *
        */
        protected function dispatchComplete():void {
            _callback(this);
            close();
        }

        /**
        * @private
        *
        * Facebook will return a 500 Internal ServerError
        * when a Graph request fails,
        * with JSON data attached explaining the error.
        *
        */
        protected function handleURLLoaderIOError(event:IOErrorEvent):void {
            _success = false;
            _rawResult = (event.target as URLLoader).data;

            if (_rawResult != '') {
                try {
                    _data = JSON.decode(_rawResult);
                } catch (e:*) {
                    _data = {type:'Exception', message:_rawResult};
                }
            } else {
                _data = event;
            }

            dispatchComplete();
        }

        /**
        * @private
        *
        */
        protected function
            handleURLLoaderSecurityError(event:SecurityErrorEvent):void {
            _success = false;
            _rawResult = (event.target as URLLoader).data;

            try {
                _data = JSON.decode((event.target as URLLoader).data);
            } catch (e:*) {
                _data = event;
            }

            dispatchComplete();
        }

        /**
        * @private
        *
        */
        protected function handleFileReferenceData(event:DataEvent):void {
            handleDataLoad(event.data);
        }

        /**
        * @private
        *
        */
        protected function handelFileReferenceError(event:ErrorEvent):void {
            _success = false;
            _data = event;

            dispatchComplete();
        }

        /**
        * @return Returns the current request URL
        * and any parameters being used.
        *
        */
        public function toString():String {
            return urlRequest.url +
                (urlRequest.data == null
                ?''
                :'?' + unescape(urlRequest.data.toString()));
        }
    }
}
