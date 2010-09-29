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
package com.facebook.delegates {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.data.FacebookData;
	import com.facebook.data.JSONDataParser;
	import com.facebook.data.JSONResultData;
	import com.facebook.errors.FacebookError;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.IFacebookSession;
	import com.facebook.session.JSSession;
	import com.facebook.utils.JavascriptRequestHelper;
	
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExternalInterface;
	
	use namespace facebook_internal;
	
	public class JSDelegate extends EventDispatcher implements IFacebookCallDelegate {
		
		protected var parser:JSONDataParser;
		
		protected var _call:FacebookCall;
		protected var _session:JSSession;
		
		protected static var externalInterfaceCallId:Number = 0;
		protected static var externalInterfaceCalls:Object = {};
		
		public function JSDelegate(call:FacebookCall, session:JSSession) {
			this.call = call;
			this.session = session;
			
			parser = new JSONDataParser();
			
			execute();
		}
		
		protected function onReceiveError(event:ErrorEvent):void {
			var fbError:FacebookError = new FacebookError();
			fbError.errorEvent = event;
			call.handleError(fbError);
		}
		
		protected function onReceiveStatus(event:StatusEvent):void {
			switch (event.level == 'error') {
				case 'error':
					var fbError:FacebookError = new FacebookError();
					fbError.rawResult = event.level;
					call.handleError(fbError);
					break;
				case 'warning':
				case 'status':
					break;
			}
		}
		
		public function get call():FacebookCall { return _call;	}
		public function set call(newVal:FacebookCall):void { this._call = newVal; }
		
		public function get session():IFacebookSession { return _session; }
		public function set session(newVal:IFacebookSession):void { this._session = newVal as JSSession; }
		
		public function close():void { }
		
		protected function execute():void {
			externalInterfaceCalls[++externalInterfaceCallId] = call;
			
			var jsCall:String = buildCall();
			
			ExternalInterface.addCallback('bridgeFacebookReply', postBridgeAsyncReply);
			ExternalInterface.call(jsCall);
		}
		
		protected function postBridgeAsyncReply(response:Object, exCallId:uint):void {
			var call:FacebookCall = externalInterfaceCalls[exCallId];
			
			handleResult( call, response );
			
			if( call.coreMethod != "Event.subscribe" )
			{
				if( call.coreMethod == "Event.unsubscribe" )
				{
					for each( var fbExCallId:uint in externalInterfaceCalls )
					{
						var fbCall:FacebookCall = externalInterfaceCalls[fbExCallId];
						if( fbCall.coreMethod == "Event.subscribe" && call[ "event" ] && fbCall[ "event" ] && call[ "event" ] == fbCall[ "event" ] )
						{
							delete externalInterfaceCalls[fbExCallId];
						}
					}
				}
				delete externalInterfaceCalls[exCallId];
			}
		}
		
		protected function handleResult( call:FacebookCall, response:Object ):void
		{
			var error:FacebookError = parser.validateFacebookResponse( response );
			
			if( !error )
			{
				var data:FacebookData = parser.parse( response, call.coreMethod, call.method );
				call.handleResult( data );
			}
			else
			{
				call.handleError( error );
			}
		}
		
		protected function buildCall():String {
			var bridgeCallFunctionName:String = "bridgeFacebookCall_"+externalInterfaceCallId;
			
			RequestHelper.formatRequest(call);
			
			var callback:String = 	"function(response) {" + 
										"document.getElementById('" + ( _session as JSSession ).as_swf_name + "').bridgeFacebookReply(response, " + externalInterfaceCallId + ")" + 
									"}";
			
			var args:String = JavascriptRequestHelper.formatURLVariables( call.args, call.schema, call.coreMethod );
			
			var params:String = call.cbIndex == 0 ? callback + ", " : "";
			params += args;
			params += call.cbIndex != 0 ? ", " + callback : "";
			
			var method:String = call.coreMethod ? call.coreMethod : "api";
			
			var jsCall:String = "function " + bridgeCallFunctionName + "() { " + 
				"FB." + method + "(" + params + ");" + 
			"}";
			
			return jsCall;
		}
	}
}