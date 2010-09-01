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
	
	import com.facebook.data.FacebookData;
	import com.facebook.errors.FacebookError;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	import flash.display.LoaderInfo;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	
	public class FacebookConnectUtil extends EventDispatcher {
		
		protected static var externalInterfaceCallId:Number = 0;
		protected static var externalInterfaceCalls:Object = {};
		protected static var hasCallback:Boolean = false;
		
		protected var _loaderInfo:LoaderInfo;
		
		public function FacebookConnectUtil(loaderInfo:LoaderInfo) {
			super();
			
			if (hasCallback == false) {
				ExternalInterface.addCallback('handleConnectCallback', handleConnectCallback);
				hasCallback = true;
			}
			
			_loaderInfo = loaderInfo;
		}
		
		public function getLoggedInUser():String {
			return ExternalInterface.call('FB.Connect.get_loggedInUser');
		}
		
		public function callMethod(methodName:String, ...params:Array):FacebookCall {
			var connectCallFunctionName:String = "bridgeFacebookCall_"+externalInterfaceCallId;
			
			var jsCall:String =
			"function " + connectCallFunctionName + "() { " + 
				"FB.Connect."+methodName+"("+JavascriptRequestHelper.formatParams(params)+", " + 
						"function(result, exception) {" + 
							"document."  + _loaderInfo.parameters.as_swf_name + ".handleConnectCallback(result, exception, " + externalInterfaceCallId + ")" + 
						"}" + 
				");" + 
			"}";
			
			ExternalInterface.call(jsCall);
			var call:FacebookCall = new FacebookCall(methodName);
			externalInterfaceCalls[externalInterfaceCallId] = call;
			
			return call;
		}
		
		protected static function handleConnectCallback(result:Object, exception:Object, externalInterfaceCallId:String):void {
			var call:FacebookCall = externalInterfaceCalls[externalInterfaceCallId];
			if (result) {
				var data:FacebookData = new FacebookData();
				data.rawResult = result as String;
				call.facebook_internal::handleResult(data);
			} else {
				var error:FacebookError = new FacebookError();
				error.rawResult = exception as String;
				call.facebook_internal::handleError(error);
			}
			
			delete externalInterfaceCalls[externalInterfaceCallId];
		}
		
	}
}