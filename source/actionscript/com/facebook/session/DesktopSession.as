package com.facebook.session {
	
	import com.facebook.commands.auth.CreateToken;
	import com.facebook.commands.auth.GetSession;
	import com.facebook.commands.photos.UploadPhoto;
	import com.facebook.commands.users.GetLoggedInUser;
	import com.facebook.data.StringResultData;
	import com.facebook.data.auth.GetSessionData;
	import com.facebook.delegates.DesktopDelegate;
	import com.facebook.delegates.IFacebookCallDelegate;
	import com.facebook.delegates.WebImageUploadDelegate;
	import com.facebook.errors.FacebookError;
	import com.facebook.events.FacebookEvent;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class DesktopSession extends WebSession implements IFacebookSession {
		
		protected var _auth_token:String;
		protected var _waiting_for_login:Boolean = false;
		protected var loginRequest:IFacebookCallDelegate;
		
		protected var _offline_access:Boolean = false;
		
		public function DesktopSession(api_key:String, secret:String = null, session_key:String=null) {
			super(api_key, null);
			
			this._is_connected = false;
			this._secret = secret;
			
			if (session_key) {
				this._session_key = session_key;
			}
		}
		
		override public function verifySession():void {
			if (_session_key) {
				var call:FacebookCall = new GetLoggedInUser();
				call.session = this;
				call.facebook_internal::initialize();
				call.addEventListener(FacebookEvent.COMPLETE, onVerifyLogin, false, 0, true);
				post(call);
				dispatchEvent(new FacebookEvent(FacebookEvent.VERIFYING_SESSION));
			} else {
				_is_connected = false;
				dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT));
			}
		}
		
		protected function onVerifyLogin(event:FacebookEvent):void {
			var successEvent:FacebookEvent = new FacebookEvent(FacebookEvent.CONNECT);
			successEvent.success = event.success;
			if (event.success) {
				facebook_internal::_uid = (event.data as StringResultData).value;
				successEvent.data = event.data;
				_is_connected = true;
			} else {
				successEvent.error = event.error;
				_is_connected = false;
			}
			dispatchEvent(successEvent);
		}
		
		override public function login(offline_access:Boolean):void {
			_offline_access = offline_access;
			
			_session_key = null;
			
			var getSession:FacebookCall = new CreateToken();
			getSession.session = this;
			getSession.facebook_internal::initialize();
			getSession.addEventListener(FacebookEvent.COMPLETE, onLogin);
			post(getSession);
		}
		
		protected function tokenCreated():void {
			navigateToURL(new URLRequest(login_url));
		}
		
		override public function get waiting_for_login():Boolean { return _waiting_for_login; }

		override public function post(call:FacebookCall):IFacebookCallDelegate {
			if (call.method == UploadPhoto.METHOD_NAME) {
				return new WebImageUploadDelegate(call, this);
			} else {
				return new DesktopDelegate(call, this);
			}
		}
		
		protected function onLogin(p_event:FacebookEvent):void {
			p_event.target.removeEventListener(FacebookEvent.COMPLETE, onLogin);
			
			if (p_event.success) {
				_auth_token = (p_event.data as StringResultData).value;
				
				//now that we have an auth_token we need the user to login with it
				var request:URLRequest = new URLRequest();
				var loginParams:String = '?';
				
				if (_offline_access) {
					loginParams += 'ext_perm=offline_access&';
				}
				
				request.url = login_url+loginParams+"api_key="+api_key+"&v="+api_version+"&auth_token="+_auth_token;
				
				navigateToURL(request, "_blank");
				
				_waiting_for_login = true;
				dispatchEvent(new FacebookEvent(FacebookEvent.WAITING_FOR_LOGIN));
			} else {
				onConnectionError(p_event.error);
			}
		}
		
		override public function refreshSession():void {
			_waiting_for_login = false;
			
			//validate the session
			var call:GetSession = new GetSession(_auth_token);
			call.session = this;
			call.facebook_internal::initialize();
			call.addEventListener(FacebookEvent.COMPLETE, validateSessionReply);
			
			post(call);
		}
		
		protected function validateSessionReply(event:FacebookEvent):void {
			if (event.success) {
				var result:GetSessionData = event.data as GetSessionData;
				facebook_internal::_uid = result.uid;
				this._session_key = result.session_key;
				this._expires = result.expires;
				
				
				// Change Serect Key (if a new one exists).
				this._secret = result.secret == null || result.secret == ''?this._secret:result.secret;
				_is_connected = true;
				
				dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT, false, false, true, result));
			} else {
				onConnectionError(event.error);
			}
		}
		
		protected function onConnectionError(error:FacebookError):void {
			_is_connected = false;
			dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT, false, false, false, null, error));
		}
	}
}