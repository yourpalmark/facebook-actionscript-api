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
package com.facebook.session  {
	
	import com.facebook.commands.users.GetLoggedInUser;
	import com.facebook.delegates.IFacebookCallDelegate;
	import com.facebook.delegates.JSDelegate;
	import com.facebook.events.FacebookEvent;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	import flash.events.EventDispatcher;

	public class JSSession extends EventDispatcher implements IFacebookSession {
		
		public var _api_key:String;
		public var as_swf_name:String;
		protected var _session_key:String;
		
		public function JSSession(api_key:String, as_swf_name:String) {
			this._api_key = api_key;
			this.as_swf_name = as_swf_name;
		}
		
		public function set rest_url(value:String):void { }
		public function get rest_url():String { return null; }
		
		public function set secret(value:String):void {  }
		public function get secret():String { return null; }
		
		public function get session_key():String { return _session_key; }
		public function set session_key(p_key:String):void { _session_key = p_key; }
		
		public function get is_connected():Boolean { return true; }

		public function get is_sessionless():Boolean { return true; }
		
		public function get waiting_for_login():Boolean { return true; }
		
		public function get api_key():String { return _api_key; }
		
		public function get expires():Date { return null; }
		
		public function get uid():String { return null; }
		
		public function get api_version():String {
			return '1.0';
		}
		
		public function verifySession():void {
			var call:FacebookCall = new GetLoggedInUser();
			call.addEventListener(FacebookEvent.COMPLETE, onVerifyLogin);
			call.session = this;
			call.facebook_internal::initialize();
			post(call);
		}
		
		protected function onVerifyLogin(event:FacebookEvent):void {
			if (event.success) {
				dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT, false, false, true));
			} else {
				dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT, false, false, false));
			}
		}
		
		public function login(offline_access:Boolean):void { }
		public function refreshSession():void { }
		
		public function post(call:FacebookCall):IFacebookCallDelegate {
			return new JSDelegate(call, this);
		}
	}
}