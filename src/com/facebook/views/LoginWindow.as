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
package com.facebook.views {
	
	import com.facebook.events.FacebookEvent;
	
	import flash.events.Event;
	import flash.html.HTMLLoader;
	
	public class LoginWindow extends BaseWindow {
		
		public static const PATH:String = 'http://www.facebook.com/login.php';
		public static const SUCCESS_PATH:String = 'http://www.facebook.com/connect/login_success.html';
		public static const FAILURE_PATH:String = 'http://www.facebook.com/connect/login_failure.html';
		
		public var sessionParams:String;
	
		public function LoginWindow(){
			super();
			
			urlVars.next = SUCCESS_PATH;
      		urlVars.cancel_url = FAILURE_PATH;
			urlVars.v = "1.0";
      		urlVars.return_session = true;
			urlVars.fbconnect = true;
			urlVars.nochrome = true;
	      	urlVars.connect_display = "popup";
			urlVars.display = "popup";
			
			req.url = PATH;	
			
			distractor.text = "Logging In";
			distractor.x = width - distractor.width >> 1;
			distractor.y = height - distractor.height >> 1;				
		}
		
		public function connect(api_key:String):void {
			urlVars.api_key = api_key;
			html.load(req);
		}
		
		override protected function onComplete(event:Event):void {			
			distractor.visible = false; //also removes the ENTER_FRAME listener on the distractor
			
			if (!closed){
				width = html.width = html.contentWidth; 
				height = html.height = html.contentHeight;
				distractor.x = width - distractor.width >> 1;
				distractor.y = height - distractor.height >> 1;
			}	
		}
		
		override protected function onLocationChange(event:Event):void {
			//login success
      		if(html.location.indexOf(SUCCESS_PATH) == 0){ 
      			sessionParams = html.location;
      			dispatchEvent(new FacebookEvent(FacebookEvent.LOGIN_SUCCESS, false, false, true));      			
      			close();
      			
      		//login failure
      		} else if (html.location.indexOf(FAILURE_PATH) == 0 || html.location.indexOf('home.php') > -1) { 
      			dispatchEvent(new FacebookEvent(FacebookEvent.LOGIN_FAILURE));
      			close();
      			
      		//show distractor
      		} else { 
				html.width = html.height = 0;
				distractor.visible = true;
      		}
		}

		override protected function onClosing(event:Event):void {
			dispatchEvent(new FacebookEvent(FacebookEvent.LOGIN_FAILURE));
		}
	}
}