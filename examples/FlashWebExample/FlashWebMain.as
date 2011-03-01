/*
	Copyright (c) 2010, Adobe Systems Incorporated
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

package {
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.Facebook;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class FlashWebMain extends Sprite {
		
		protected static const APP_ID:String = "YOUR_APP_ID"; //Place your application id here
		
		public function FlashWebMain() {	
			configUI();
		}
		
		protected function configUI():void {
			
			uiParamsInput.text = '{"message": "this is a message"}';
				
			//hide the params input by default
			paramsLabel.visible = paramsInput.visible = false;			
			
			//listeners for UI
			loginToggleBtn.addEventListener(MouseEvent.CLICK, handleLoginClick, false, 0, true);
			callApiBtn.addEventListener(MouseEvent.CLICK, handleCallApiClick, false, 0, true);			
			showUIBtn.addEventListener(MouseEvent.CLICK, handleUIClick, false, 0, true);
			getRadio.addEventListener(MouseEvent.CLICK, handleReqTypeChange, false, 0, true);
			postRadio.addEventListener(MouseEvent.CLICK, handleReqTypeChange, false, 0, true);
			clearBtn.addEventListener(MouseEvent.CLICK, handleClearClick, false, 0, true);
			
			//Initialize Facebook library
			Facebook.init(APP_ID, onInit);			
		}
		
		protected function onInit(result:Object, fail:Object):void {						
			if (result) { //already logged in because of existing session
				outputTxt.text = "onInit, Logged In\n";
				loginToggleBtn.label = "Log Out";
			} else {
				outputTxt.text = "onInit, Not Logged In\n";
			}
		}
		
		protected function handleLoginClick(event:MouseEvent):void {
			if (loginToggleBtn.label == "Log In") {				
				var opts:Object = {perms:"publish_stream, user_photos"};
				Facebook.login(onLogin, opts);
			} else {
				Facebook.logout(onLogout);
			}
		}
		
		protected function onLogin(result:Object, fail:Object):void {
			if (result) { //successfully logged in
				outputTxt.text = "Logged In";
				loginToggleBtn.label = "Log Out";
			} else {
				outputTxt.appendText("Login Failed\n");				
			}
		}
		
		protected function onLogout(success:Boolean):void {			
			outputTxt.text = "Logged Out";
			loginToggleBtn.label = "Log In";				
		}
		
		protected function handleReqTypeChange(event:MouseEvent):void {
			if (getRadio.selected) {			
				paramsLabel.visible = paramsInput.visible = false; 
			} else {
				paramsLabel.visible = paramsInput.visible = true; //only POST request types have params
			}
		}
		
		protected function handleCallApiClick(event:MouseEvent):void {
			var requestType:String = getRadio.selected ? "GET" : "POST";
			var params:Object = null;	
			if (requestType == "POST") {
				try {
					params = JSON.decode(paramsInput.text);
				} catch (e:Error) {
					outputTxt.appendText("\n\nERROR DECODING JSON: " + e.message);
				}
			}
			
			Facebook.api(methodInput.text, onCallApi, params, requestType); //use POST to send data (as per Facebook documentation)
		}
		
		protected function handleUIClick(event:MouseEvent):void {			
			var method:String = uiMethodInput.text;
			if (method.length) {
				var data:Object = {};
				try {
					data = JSON.decode(uiParamsInput.text);	
				} catch (e:Error) {
					outputTxt.appendText("\n\nERROR DECODING JSON: " + e.message);
				}			
			
				Facebook.ui(method, data, onUICallback);
			} else {
				outputTxt.appendText("\n\nPlease specify dialog type");
			}
		}
		
		protected function onUICallback(result:Object):void {
			outputTxt.appendText("\n\nUICallback: " + JSON.encode(result));
		}
		
		protected function onCallApi(result:Object, fail:Object):void {
			if (result) {
				outputTxt.appendText("\n\nRESULT:\n" + JSON.encode(result)); 
			} else {
				outputTxt.appendText("\n\nFAIL:\n" + JSON.encode(fail)); 
			}
		}
		
		protected function handleClearClick(event:MouseEvent):void {
			outputTxt.text = "";
		}
	}
}