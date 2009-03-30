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