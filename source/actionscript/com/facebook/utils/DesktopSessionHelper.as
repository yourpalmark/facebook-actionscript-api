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
package com.facebook.utils {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.Facebook;
	import com.facebook.air.JSONCall;
	import com.facebook.air.JSONEvent;
	import com.facebook.air.SessionData;
	import com.facebook.commands.auth.ExpireSession;
	import com.facebook.commands.auth.RevokeExtendedPermission;
	import com.facebook.commands.users.GetLoggedInUser;
	import com.facebook.commands.users.HasAppPermission;
	import com.facebook.data.BooleanResultData;
	import com.facebook.data.StringResultData;
	import com.facebook.data.auth.ExtendedPermissionValues;
	import com.facebook.errors.FacebookError;
	import com.facebook.events.FacebookEvent;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.DesktopSession;
	import com.facebook.views.LoginWindow;
	import com.facebook.views.PermissionWindow;
	
	import flash.display.NativeWindow;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.html.HTMLLoader;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	
	public class DesktopSessionHelper extends EventDispatcher {
		
		public var apiKey:String;
		public var loginWin:LoginWindow;
		public var permissionWin:PermissionWindow;
		
		public var allPermissions:Array = [ ExtendedPermissionValues.EMAIL,
											ExtendedPermissionValues.READ_MAILBOX,
											ExtendedPermissionValues.OFFLINE_ACCESS,
											ExtendedPermissionValues.STATUS_UPDATE,
											ExtendedPermissionValues.PHOTO_UPLOAD,
											ExtendedPermissionValues.VIDEO_UPLOAD,
											ExtendedPermissionValues.CREATE_EVENT,
											ExtendedPermissionValues.CREATE_NOTE,
											ExtendedPermissionValues.RSVP_EVENT,
											ExtendedPermissionValues.SMS,
											ExtendedPermissionValues.SHARE_ITEM,
											ExtendedPermissionValues.CREATE_LISTING,
											ExtendedPermissionValues.PUBLISH_STREAM,
											ExtendedPermissionValues.READ_STREAM ];
		
		public var facebook:Facebook;		
		public var sessionData:SessionData;
		
		protected var sessionSO:SharedObject;
		protected var parentWindow:NativeWindow;
		
		protected var permissions:Object; //hash of permission strings and if they granted
		protected var queuedGrantPermissions:Array; //list of permissions to grant
		protected var queuedRevokePermissions:Array; //list of permissions to revoke
		protected var queuedHasPermissions:Array; //list of permissions to check
		
		public function DesktopSessionHelper(api_key:String='', parent:NativeWindow=null){
			super();
			permissions = {};
			queuedGrantPermissions = [];
			queuedRevokePermissions = [];
			queuedHasPermissions = [];
			
			parentWindow = parent;
			
			apiKey = api_key;
			if(apiKey != ''){ login(apiKey); }
		}
		
		public function login(api_key:String=''):void {
			if (api_key != '') { apiKey = api_key; }
			if (apiKey == '') { throw new Error('Cannot login. No api_key specified.'); }
			
			//check for existing LSO with sessionData	
			sessionSO = SharedObject.getLocal(apiKey);
			
			if(sessionSO.data.session_key != null){
	      		populateSessionData(sessionSO.data);
      			
      			facebook = new Facebook();
      			facebook.startSession(new DesktopSession(apiKey, sessionData.secret, sessionData.session_key));			
      			
      			//check that the current session is still active 
				var call:FacebookCall = facebook.post(new GetLoggedInUser());
				call.addEventListener(FacebookEvent.COMPLETE, onValidateLoginSession, false, 0, true);
			} else {
				showLogin();
			}
		}
		
		public function verifySession():void {
			sessionSO = SharedObject.getLocal(apiKey);
			if(sessionSO.data.session_key != null){
	      		populateSessionData(sessionSO.data);
      			
      			facebook = new Facebook();
      			facebook.startSession(new DesktopSession(apiKey, sessionData.secret, sessionData.session_key));			
      			
      			//check that the current session is still active 
				var call:FacebookCall = facebook.post(new GetLoggedInUser());
				call.addEventListener(FacebookEvent.COMPLETE, onValidateSession, false, 0, true); 
			} else {
				dispatchEvent(new FacebookEvent(FacebookEvent.VERIFYING_SESSION)); 
			}
		}
		
		public function logout():void {
			if(sessionSO == null){
				if(apiKey == ''){
					throw new Error('Cannot logout. No api_key specified.');
				} else {
					sessionSO = SharedObject.getLocal(apiKey);
				}
			} else {
				var call:FacebookCall = facebook.post(new ExpireSession());
				call.addEventListener(FacebookEvent.COMPLETE, onExpireSession, false, 0, true);  
			}
		}
		
		public function shutdown():void {
			if(loginWin != null && !loginWin.closed){ loginWin.close(); }
			
			if(permissionWin != null && !permissionWin.closed){ permissionWin.close(); }
		}
		
		//asynchronous, dispatches permission_status event. use checkFacebook=true to force a server call for the latest permission value
		public function hasPermission(perm:String, checkFacebook:Boolean=false):void {
			//ensures that we're logged in
			if(sessionData == null){
				login(apiKey);		
			} else {			
				if(checkFacebook){
					queuedHasPermissions.push(perm);
					var call:FacebookCall = facebook.post(new HasAppPermission(perm, sessionData.uid));
					call.addEventListener(FacebookEvent.COMPLETE, onHasPermissionComplete, false, 0, true); 
				} else {
					var hasPermission:Boolean = Boolean(permissions[perm]);				
					dispatchEvent(new FacebookEvent(FacebookEvent.PERMISSION_STATUS, false, false, false, null, null, perm, hasPermission));
				}
			}
		}
		
		//checks the local cached permissions hash
		public function checkPermission(perm:String):Boolean {
			return Boolean(permissions[perm]);
		}
		
		public function grantPermissions(perms:Array):void {
			queuedGrantPermissions = perms;
			
			if(sessionData == null){
				login(apiKey); 
			} else {
				//check the login status (http://www.facebook.com/extern/desktop_login_status.php)
				var html:HTMLLoader = new HTMLLoader();
				html.addEventListener(Event.LOCATION_CHANGE, onCheckLoginLocationChange, false, 0, true);				
				html.load(new URLRequest('http://www.facebook.com/extern/desktop_login_status.php?next=http://www.facebook.com/connect/login_success.html&api_key='+apiKey));
			}
		}
		
		public function revokePermissions(perms:Array):void {
			queuedRevokePermissions = perms;
			
			if(sessionData == null){
				login(apiKey); 
			} else {
				//make calls to revoke...
				var temp:Array = [];
				while(queuedRevokePermissions.length){
					var perm:String = queuedRevokePermissions.shift();
					temp.push(perm);
					
					var call:FacebookCall = facebook.post(new RevokeExtendedPermission(perm, sessionData.uid));
					call.addEventListener(FacebookEvent.COMPLETE, onRevokePermissionComplete, false, 0, true);
				}
				queuedRevokePermissions = temp; //need to keep a record of permission names for use in onRevokePermissionComplete handler
			}
		}
		
		protected function showLogin():void {
			loginWin = new LoginWindow();
			loginWin.addEventListener(FacebookEvent.LOGIN_SUCCESS, onLoginSuccess, false, 0, true);
			loginWin.addEventListener(FacebookEvent.LOGIN_FAILURE, onLoginFailure, false, 0, true)
			
			loginWin.connect(apiKey);
			
			if(parentWindow != null){
				loginWin.x = parentWindow.x;
				loginWin.y = parentWindow.y;
			}
			
			dispatchEvent(new FacebookEvent(FacebookEvent.LOGIN_WINDOW_SHOW));
		}
		
		protected function populateSessionData(sessionObj:Object):void {
			sessionData = new SessionData();
			sessionData.session_key = sessionObj.session_key;
      		sessionData.secret = sessionObj.secret;
      		sessionData.expires = sessionObj.expires;
	      	sessionData.uid = sessionObj.uid;
		}
		
		//checks the enabled/disabled status for all permissions, populates permissions hash
		protected function getPermissions():void {
			var call:JSONCall = new JSONCall(sessionData, apiKey);
			call.addEventListener(JSONEvent.SUCCESS, onGetPermissionsSuccess, false, 0, true);
		    call.addEventListener(JSONEvent.FAILURE, onGetPermissionsFailure, false, 0, true);
		    call.addEventListener(IOErrorEvent.IO_ERROR, onGetPermissionsIOError, false, 0, true);
		    call.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onGetPermissionsSecurityError, false, 0, true);
		    call.call( "fql.query", {query:"select "+allPermissions.join(", ")+" from permissions where uid = "+sessionData.uid} );
		}
		
		protected function onGetPermissionsSuccess(event:JSONEvent):void {
			permissions = (event.data as Array)[0]; 
			dispatchEvent(new FacebookEvent(FacebookEvent.PERMISSIONS_LOADED, false, false, true));
		}
		
		protected function onGetPermissionsFailure(event:JSONEvent):void {
			var error:FacebookError = new FacebookError();
			error.errorMsg = "Getting Permissions Failure";			
			dispatchEvent(new FacebookEvent(FacebookEvent.ERROR, false, false, false, null, error));
		}
		
		protected function onGetPermissionsIOError(event:IOErrorEvent):void {
			var error:FacebookError = new FacebookError();
			error.errorMsg = "Getting Permissions IO Error";	
			error.errorEvent = event;
			dispatchEvent(new FacebookEvent(FacebookEvent.ERROR, false, false, false, null, error));			
		}
		
		protected function onGetPermissionsSecurityError(event:SecurityErrorEvent):void {
			var error:FacebookError = new FacebookError();
			error.errorMsg = "Getting Permissions Security Error";
			error.errorEvent = event;
			dispatchEvent(new FacebookEvent(FacebookEvent.ERROR, false, false, false, null, error));
		}
		
		protected function onHasPermissionComplete(event:FacebookEvent):void {
			var perm:String = queuedHasPermissions.shift();
			if(event.success){
				var hasPermission:Boolean = (event.data as BooleanResultData).value;				
				dispatchEvent(new FacebookEvent(FacebookEvent.PERMISSION_STATUS, false, false, true, null, null, perm, hasPermission));
			} else {
				var error:FacebookError = new FacebookError();
				error.errorMsg = "HasPermission call failed";
				dispatchEvent(new FacebookEvent(FacebookEvent.ERROR, false, false, false, null, error));
			}
		}
		
		protected function onRevokePermissionComplete(event:FacebookEvent):void {
			var perm:String = queuedRevokePermissions.shift();
			
			if (event.success) {
				dispatchEvent(new FacebookEvent(FacebookEvent.PERMISSION_CHANGE, false, false, true, null, null, perm, false)); 
			} else {
				var error:FacebookError = new FacebookError();
				error.errorMsg = "RevokePermission call failed";
				dispatchEvent(new FacebookEvent(FacebookEvent.ERROR, false, false, false, null, error));
			}
		}
		
		protected function onCheckLoginLocationChange(event:Event):void {
			/*although we might have logged in (via lso session), the permissions page 
			requires that we login on the connect page before it allows us to see the permissions page*/
			var url:String = (event.target as HTMLLoader).location;
			
			if (url.indexOf("result=logged_in") > -1) { //logged in
				permissionWin = new PermissionWindow();
				permissionWin.addEventListener(Event.CLOSE, onPermissionWinClose, false, 0, true);
				permissionWin.askPermissions(queuedGrantPermissions, apiKey);
				queuedGrantPermissions = [];
				dispatchEvent(new FacebookEvent(FacebookEvent.PERMISSIONS_WINDOW_SHOW));
			} else if(url.indexOf("result=not_logged_in") > -1){ //not logged in
				showLogin();
			}
		}
		
		protected function onPermissionWinClose(event:Event):void {
			getPermissions();
		}
		
		//handler for checking existing session when login() is called
		protected function onValidateLoginSession(event:FacebookEvent):void {
			if (event.success && (event.data as StringResultData).value == sessionData.uid) {
				getPermissions();
				
				if (queuedGrantPermissions.length) { grantPermissions(queuedGrantPermissions); }
				
				dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT, false, false, true));
			} else {
				sessionSO.clear();
				sessionSO.flush();
				sessionData = null;
				login(apiKey);
			}
		}
		
		//handler for checking existing session when verifySession() is called
		protected function onValidateSession(event:FacebookEvent):void {
			if (event.success && (event.data as StringResultData).value == sessionData.uid) {
				getPermissions();
				dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT, false, false, true));
			} else {
				sessionSO.clear();
				sessionSO.flush();
				sessionData = null;
				dispatchEvent(new FacebookEvent(FacebookEvent.VERIFYING_SESSION));
			}
		}
		
		protected function onExpireSession(event:FacebookEvent):void {
			sessionSO.clear();
			sessionSO.flush();
			sessionData = null;
			dispatchEvent(new FacebookEvent(FacebookEvent.LOGOUT, false, false, true));
		}
		
		protected function onLoginSuccess(event:FacebookEvent):void {
			var sessionPattern:RegExp = /\{.+?\}/;
      		var sessionJson:String = sessionPattern.exec(unescape(loginWin.sessionParams))[0];
      		var sessionObj:Object = JSON.decode(sessionJson);
      		
      		populateSessionData(sessionObj);
      		
      		facebook = new Facebook();
      		facebook.startSession(new DesktopSession(apiKey, sessionData.secret, sessionData.session_key));
      		
      		getPermissions();
      		
      		if(queuedGrantPermissions.length){ grantPermissions(queuedGrantPermissions); }
      		
      		//save session to lso      		
      		sessionSO.data.session_key = sessionData.session_key;
      		sessionSO.data.secret = sessionData.secret;
      		sessionSO.data.expires = sessionData.expires;
      		sessionSO.data.uid = sessionData.uid;
      		sessionSO.flush();
      		
      		dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT, false, false, true));
		}
		
		protected function onLoginFailure(event:FacebookEvent):void {
			dispatchEvent(event);
		}
	}
}