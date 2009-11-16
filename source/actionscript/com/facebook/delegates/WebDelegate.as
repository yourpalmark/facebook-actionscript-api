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
	
	import com.facebook.data.FacebookData;
	import com.facebook.data.FacebookErrorCodes;
	import com.facebook.data.FacebookErrorReason;
	import com.facebook.data.XMLDataParser;
	import com.facebook.errors.FacebookError;
	import com.facebook.events.FacebookEvent;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.IFacebookSession;
	import com.facebook.session.WebSession;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	use namespace facebook_internal;
	
	public class WebDelegate extends EventDispatcher implements IFacebookCallDelegate {
		
		protected var parser:XMLDataParser;
		
		protected var _call:FacebookCall;
		protected var _session:WebSession;
		
		protected var loader:URLLoader;
		protected var fileRef:FileReference;
		
		public function get call():FacebookCall { return _call; }
		public function set call(newVal:FacebookCall):void { _call = newVal; }

		public function get session():IFacebookSession { return _session; }
		public function set session(newVal:IFacebookSession):void { _session = newVal as WebSession; }
		
		public function WebDelegate(call:FacebookCall, session:WebSession) {
			this.call = call;
			this.session = session;
			
			parser = new XMLDataParser();
			
			execute();
		}
		
		public function close():void {
			try {
				loader.close();
			} catch (e:*) { }
		}
		
		protected function execute():void {
			if (call == null) { throw new Error('No call defined.'); }
			
			post();
		}

		/**
		 * Helper function for sending the call straight to the server
		 */
		protected function post():void {
			addOptionalArguments();
			
			RequestHelper.formatRequest(call);
			
			//Have a seperate method so sub classes can override this if need be (WebImageUploadDelegate, is an example)
			sendRequest();
		}
		
		protected function sendRequest():void {
			//construct the loader
			createURLLoader();
			
			//create the service request for normal calls
			var req:URLRequest = new URLRequest(_session.rest_url);
			req.contentType = "application/x-www-form-urlencoded";
			req.method = URLRequestMethod.POST;
			
			req.data = call.args;
			
			trace(req.url + '?' + unescape(call.args.toString()));
			
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(req);
		}
		
		protected function createURLLoader():void {
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onDataComplete);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
		
		protected function onHTTPStatus(p_event:HTTPStatusEvent):void { }
		
		/**
		 * Add arguments here that might be class session-type specific
		 */
		protected function addOptionalArguments():void {
			//setting thes 'ss' argument to true
			//since that's what we should be using for a web session
			call.setRequestArgument("ss", true);
		}
		
		// Event Handlers
		protected function onDataComplete(p_event:Event):void {
			//trace(_call.method, p_event);
			handleResult(p_event.target.data as String);
		}
		
		protected function onError(p_event:ErrorEvent):void {
			//trace(_call.method, p_event);
			clean();
			
			var fbError:FacebookError = parser.createFacebookError(p_event, loader.data); 
			
			call.handleError(fbError);
			
			dispatchEvent(new FacebookEvent(FacebookEvent.COMPLETE, false, false, false, null, fbError));
		}
		
		protected function handleResult(result:String):void {
			clean();
			
			var error:FacebookError = parser.validateFacebookResponce(result);
			var fbData:FacebookData;
			
			if (error == null) {
				fbData = parser.parse(result, call.method);
				call.handleResult(fbData);
			} else {
				call.handleError(error);
			}
		}
		
		protected function clean():void {
			if (loader == null) { return; }
			
			loader.removeEventListener(Event.COMPLETE, onDataComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
	}
}