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
package com.facebook.events {
	
	import com.facebook.data.FacebookData;
	import com.facebook.errors.FacebookError;
	
	import flash.events.Event;

	public class FacebookEvent extends Event {
		
		public static const COMPLETE:String = "complete";
		public static const WAITING_FOR_LOGIN:String = "waitingForLogin";
		public static const VERIFYING_SESSION:String = "verifyingSession";
		public static const CONNECT:String = "connect";
		public static const LOGOUT:String = "logout";
		public static const LOGIN_SUCCESS:String = "loginSuccess";
		public static const LOGIN_FAILURE:String = "loginFailure";
		public static const PERMISSIONS_LOADED:String = "permissionsLoaded";
		public static const PERMISSION_STATUS:String = "permissionStatus";
		public static const PERMISSION_CHANGE:String = "permissionChanged";
		public static const LOGIN_WINDOW_SHOW:String = 'loginWindoShow';
		public static const PERMISSIONS_WINDOW_SHOW:String = 'permissionsWindowShow';
		public static const ERROR:String ="facebookEventError";
		
		/**
		 * Public access for data returned from the Facebook API. 
		 * 
		 */
		public var success:Boolean;
		public var data:FacebookData;
		public var error:FacebookError;
		public var permission:String;
		public var hasPermission:Boolean;
		
		public function FacebookEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, success:Boolean=false, data:FacebookData=null, error:FacebookError=null, permission:String='', hasPermission:Boolean=false) {
			this.success = success;
			this.data = data;
			this.error = error;
			this.permission = permission;
			this.hasPermission = hasPermission;
			
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new FacebookEvent(type, bubbles, cancelable, success, data, error);
		}
		
		override public function toString():String {
			return formatToString('FacebookEvent', 'type', 'success', 'data', 'error');
		}
		
	}
}