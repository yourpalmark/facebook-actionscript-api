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
package com.facebook {
	
	import com.facebook.commands.auth.ExpireSession;
	import com.facebook.delegates.IFacebookCallDelegate;
	import com.facebook.events.FacebookEvent;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.IFacebookSession;
	
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	use namespace facebook_internal;
	
	/**
	 * Top level class for the ActionScript 3.0 Client Library for Facebook Platform.
	 * The Facebook class provides access not only to information about the current 
	 * Facebook session, but also to session management methods, such as logging
	 * in, starting, posting commands, refreshing, and logging out of a session. 
	 * The Facebook class also provides access to application-level management
	 * methods that ask users for normal and extended permissions for your application.
	 * 
	 * @see http://code.google.com/p/facebook-actionscript-api/
	 * @see com.facebook.session
	 */
	public class Facebook extends EventDispatcher {
		
		public var connectionErrorMessage:String;
		public var waiting_for_login:Boolean;
		/** @private */
		protected var _currentSession:IFacebookSession;
		
		public function Facebook():void { }
		
		//Setters / Getters
		/**
		 * Indicates whether the current session is active, and therefore connected to the Facebook server.
		 */
		public function get is_connected():Boolean  { return _currentSession ? this._currentSession.is_connected : false; }
		/**
		 * Your application's API key, which identifies your application on the Facebook platform.
		 * @see http://developers.facebook.com/get_started.php
		 */
		public function get api_key():String  { return _currentSession ? this._currentSession.api_key : null; }
		/**
		 * Your Facebook application secret, which Facebook uses to authenticate calls from your application.
		 * Note, however, that this property can sometimes contain the session secret rather than the
		 * application secret, depending on the context. For more information about session secrets, see the
		 * "Session_Secret" link in the "See also" section.
		 * @see http://developers.facebook.com/get_started.php
		 * @see http://wiki.developers.facebook.com/index.php/Session_Secret
		 */
		public function get secret():String { return _currentSession ? this._currentSession.secret : null; } 
		/**
		 * The current session's session key, which identifies the current session on the Facebook platform.
		 * @see http://wiki.developers.facebook.com/index.php/Authorizing_Applications#About_Session_Keys
		 */
		public function get session_key():String  { return _currentSession ? this._currentSession.session_key : null; }
		/**
		 * The time when the current session will expire. More precisely, this is a value returned by
		 * the Facebook server&#x2014;the <code>fb_sig_expires</code> parameter&#x2014;that indicates when the current 
		 * session key will expire. 
		 * @see http://wiki.developers.facebook.com/index.php/Authorizing_Applications#Parameters_Passed_to_Your_Application
		 */
		public function get expires():Date  { return _currentSession ? this._currentSession.expires : new Date(); }
		/**
		 * The Facebook User ID for the user involved in the current session.
		 * @see http://wiki.developers.facebook.com/index.php/User_ID
		 */
		public function get uid():String { return _currentSession ? this._currentSession.uid : null; }
		public function get api_version():String  { return _currentSession ? this._currentSession.api_version : null; }
		
		public function startSession(session:IFacebookSession):void {
			_currentSession = session;
			if (_currentSession.is_connected) {
				dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT, false, false, true));
			} else {
				_currentSession.addEventListener(FacebookEvent.CONNECT, onSessionConnected);
				_currentSession.addEventListener(FacebookEvent.WAITING_FOR_LOGIN, onWaitingForLogin);
			}
		}
		
		public function post(call:FacebookCall):FacebookCall {
			if (_currentSession) {
				call.session = _currentSession;
				call.facebook_internal::initialize();
				
				var delegate:IFacebookCallDelegate = _currentSession.post(call);
				call.delegate = delegate;
			} else {
				throw new Error("Cannot post a call; no session has been set.");
			}
			return call;
		}
		
		/**
		 * Navigates to a Facebook URL that prompts the user to grant extended permissions for your application.
		 * <p>The "offline access" permission is an example of an extended permission that a user can grant
		 * to your application. This permission allows your application to access a user's profile even if the
		 * user is offline or does not have an active session. 
		 * </p>
		 * @see http://wiki.developers.facebook.com/index.php/Extended_permissions
		 */
		public function grantExtendedPermission(perm:String):void {
			navigateToURL(new URLRequest('http://www.facebook.com/authorize.php?api_key='+api_key+'&v='+api_version+'&ext_perm='+perm), '_blank');
		}
		
		/**
		 * Navigates to a Facebook URL that checks whether the user has granted your application access
		 * to the user's profile and if not, prompts the user to grant basic authorization.
		 */
		public function grantPermission(return_session:Boolean):void {
			var authUrl:String = 'http://www.facebook.com/login.php?return_session=' + (return_session?1:0) + '&api_key=' + api_key;
			navigateToURL(new URLRequest(authUrl), '_blank');
		}
		
		public function login(offline_access:Boolean):void {
			_currentSession.login(offline_access);
		}
		
		/**
		 * Send a logout request to Facebook.
		 * 
		 */
		public function logout():void {
			var call:ExpireSession = new ExpireSession();
			call.addEventListener(FacebookEvent.COMPLETE, onLoggedOut, false, 0, true);
			post(call);
		}
		
		public function refreshSession():void {
			_currentSession.refreshSession();
		}
		
		/**
		 * Helper function.  Called when the connection is ready.
		 * 
		 */
		protected function onSessionConnected(event:FacebookEvent):void {
			var session:IFacebookSession = event.target as IFacebookSession;
			dispatchEvent(event);
		}
		
		protected function onWaitingForLogin(event:FacebookEvent):void {
			waiting_for_login = true;
			dispatchEvent(new FacebookEvent(FacebookEvent.WAITING_FOR_LOGIN));
		}
		
		protected function onLoggedOut(event:FacebookEvent):void {
			if (event.success == true) {
				_currentSession.session_key = null;
			}
			
			dispatchEvent(new FacebookEvent(FacebookEvent.LOGOUT, false, false, event.success, event.data, event.error));
		}
		
	}
}