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
package com.facebook.session {
	
	import com.facebook.delegates.IFacebookCallDelegate;
	import com.facebook.delegates.VideoUploadDelegate;
	import com.facebook.delegates.WebDelegate;
	import com.facebook.delegates.WebImageUploadDelegate;
	import com.facebook.events.FacebookEvent;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.net.IUploadPhoto;
	import com.facebook.net.IUploadVideo;
	
	import flash.events.EventDispatcher;

	/**
	 * The WebSession class represents a Facebook session that is conducted
	 * through a web browser using Flash Player. To create a Facebook
	 * session that is conducted through a desktop application (i.e. Adobe AIR),
	 * use the DesktopSession class instead.
	 *
	 * <p>Although a web session can be conducted by embedding your application's
	 * secret into your SWF file by including your application secret
	 * as the second argument to the WebSession constructor, this technique is not secure
	 * because your SWF file can be decompiled and your application secret would 
	 * then be exposed. </p>
	 * <p>Fortunately, Facebook offers a more secure technique that allows you to avoid 
	 * embedding your application secret into your SWF file. This alternative approach uses a
	 * session secret, which is separate from your application secret but provides
	 * similar functionality. Facebook sends a session secret for any active session
	 * of your application. This session secret is specific to both
	 * your application and the user, and allows your application to make Facebook
	 * API calls on behalf of that user. </p>
	 * <p>Currently, the only way to access this session secret is to use the FacebookSessionUtil
	 * class to create your web session instead of the WebSession class. The FacebookSessionUtil 
	 * class constructor looks for this session secret and if possible, creates an 
	 * instance of the WebSession class for you with the session secret instead of your
	 * application secret. Although
	 * you may see introductory tutorial examples that explicitly call the 
	 * WebSession constructor, you should generally opt for the more secure approach
	 * of calling the FacebookSessionUtil constructor instead.
	 * </p>
	 * 
	 * @see com.facebook.utils.FacebookSessionUtil
	 * @see http://wiki.developers.facebook.com/index.php/Session_Secret
	 */
	public class WebSession extends EventDispatcher implements IFacebookSession {
		
		public static const REST_URL:String = "http://api.facebook.com/restserver.php";
		public static const VIDEO_URL:String = "http://api-video.facebook.com/restserver.php";
		
		/** @private */
		protected var _api_key:String; 
		
		/** @private */
		protected var _secret:String;
		/** @private */
		protected var _session_key:String;
		/** @private */
		facebook_internal var _uid:String;
		/** @private */
		protected var _expires:Date;
		/** @private */
		protected var _api_version:String = "1.0";
		/** @private */
		protected var _is_connected:Boolean = false;
		/** @private */
		protected var _rest_url:String = REST_URL;
		
		/**
		 * The URL of the login page a user will be directed to (for desktop applications)
		 * The default will work fine but you can set it to something else.
		 */
		public var login_url:String = "http://www.facebook.com/login.php";
		
		public function WebSession(api_key:String, ss:String, session_key:String = null) {
			super();
			
			this._api_key = api_key;
			this._session_key = session_key;
			this.secret = ss;
		}
		
		public function verifySession():void {
			if (_session_key) {
				_is_connected = true;
				dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT, false, false, true));
			} else {
				_is_connected = false;
				dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT, false, false, false));
			}
		}
		
		public function get is_connected():Boolean { return _is_connected; }
		
		/**
		 * The URL of the REST server that you will be using.
		 * The default value is "http://api.facebook.com/restserver.php".
		 */
		public function set rest_url(value:String):void { _rest_url = value; }
		public function get rest_url():String { return _rest_url; }
		
		public function get api_version():String { return this._api_version; }
		public function set api_version(newVal:String):void { this._api_version = newVal; }

		/** 
		 * Your application's API key.
		 */
		public function get api_key():String { return _api_key;	}
		
		/**
		 * Your application's secret. If you call the WebSession constructor
		 * manually, you must use your application's secret. However, Facebook 
		 * recommends that you use a more secure technique that involves a session
		 * secret. To use a session secret, use the FacebookSessionUtil
		 * class to create your web session.
		 * @see com.facebook.utils.FacebookSessionUtil
		 * @see http://wiki.developers.facebook.com/index.php/Session_Secret
		 */
		public function set secret(value:String):void {  _secret = value;; }
		public function get secret():String { return _secret; }
		
		public function get session_key():String { return _session_key; }
		public function set session_key(p_key:String):void { _session_key = p_key; }
		
		public function get expires():Date { return _expires; }
		public function get uid():String { return facebook_internal::_uid; }
		public function get waiting_for_login():Boolean { return false; }
		
		public function login(offline_access:Boolean):void {
			//Theres no need to call login here, since teh user is alredy in facebook.
				//You should pop a dialog or something similar to notify the user they're not logged into facebook.
				//Maybe we want to direct the user to login.php here?
		}
		
		public function refreshSession():void {
			//Theres no need to call login here (since the user is already logged into facebook);
		}
		
		public function post(call:FacebookCall):IFacebookCallDelegate {
			rest_url = REST_URL; //reset the rest_url to default. (video uses a different one);
			
			if (call is IUploadPhoto) {
				return new WebImageUploadDelegate(call, this);
			} else if (call is IUploadVideo) {
				rest_url = VIDEO_URL; //video uploads need to hit this url
				return new VideoUploadDelegate(call, this);
			} else {
				return new WebDelegate(call, this); 
			}
		}
		
	}
}