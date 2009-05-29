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
package com.facebook.air {
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class JSONCall extends EventDispatcher {
		
		protected var req:URLRequest; 
		protected var loader:URLLoader;
		protected var sessionData:SessionData;
		protected var apiKey:String;
		
		public function JSONCall(session:SessionData, api_key:String){
			super();
			
			sessionData = session;
			apiKey = api_key;
			
			req = new URLRequest("http://api.facebook.com/restserver.php");
			req.contentType = "application/x-www-form-urlencoded";
      		req.method = URLRequestMethod.GET;
      		
			loader = new URLLoader();
      		loader.dataFormat = URLLoaderDataFormat.TEXT;
      		loader.addEventListener(Event.COMPLETE, onComplete);
      		loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
      		loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		public function call(method:String, params:Object=null):void {
			//parse the params into urlVars
			var urlVars:URLVariables = new URLVariables();
			for(var prop:String in params){ urlVars[prop] = params[prop]; }
			urlVars.v = '1.0';
		    urlVars.format = 'JSON';
		    urlVars.method = method;
		    urlVars.api_key = apiKey;
		    urlVars.call_id = new Date().time.toString();
		    urlVars.session_key = sessionData.session_key;
		    
		    //get all the url variable values, sort them, append the secret key, MD5 hash it, and finally assign it to 'sig' on urlVars
		    var args:Array = new Array();
		    for(var key:String in urlVars){ args.push(key + '=' + urlVars[key]); }
		    args.sort();
		    urlVars.sig = MD5.hash(args.join("") + sessionData.secret);
      		
			req.data = urlVars;
			loader.load(req);
		}
		
		protected function onComplete(event:Event):void {
			var result:String = loader.data;
			if(result.indexOf("<") != 0){
				var decodedObj:* = JSON.decode(result);
				if(decodedObj.constructor == Object && decodedObj.error_code) {
					dispatchEvent(new JSONEvent(JSONEvent.FAILURE, decodedObj));
				} else {
					dispatchEvent(new JSONEvent(JSONEvent.SUCCESS, decodedObj)); 
				}
			} else {
				dispatchEvent(new JSONEvent(JSONEvent.FAILURE));
			}
		}
		
		protected function onIOError(event:IOErrorEvent):void {
			dispatchEvent(event);
		}
		
		protected function onSecurityError(event:SecurityErrorEvent):void {
			dispatchEvent(event);
		}
	}
}