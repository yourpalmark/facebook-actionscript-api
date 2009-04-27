package com.facebook.delegates {
	
	import com.adobe.serialization.json.JSON;
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
	
	public class JSDelegate extends EventDispatcher implements IFacebookCallDelegate {
		
		protected var _call:FacebookCall;
		protected var _session:JSSession;
		
		protected static var externalInterfaceCallId:Number = 0;
		protected static var externalInterfaceCalls:Object = {};
		
		public function JSDelegate(call:FacebookCall, session:JSSession) {
			this.call = call;
			this.session = session;
			
			execute();
		}
		
		protected function onReceiveError(event:ErrorEvent):void {
			var fbError:FacebookError = new FacebookError();
			fbError.errorEvent = event;
			call.facebook_internal::handleError(fbError);
		}
		
		protected function onReceiveStatus(event:StatusEvent):void {
			switch (event.level == 'error') {
				case 'error':
					var fbError:FacebookError = new FacebookError();
					fbError.rawResult = event.level;
					call.facebook_internal::handleError(fbError);
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
			var a:Array = [];
			for each(var o:Object in call.args) {
				a.push(o);
			}
			
			externalInterfaceCalls[++externalInterfaceCallId] = call;
			
			var jsCall:String = buildCall();
			
			ExternalInterface.addCallback('bridgeFacebookReply', postBridgeAsyncReply);
			ExternalInterface.call(jsCall);
		}
		
		protected function postBridgeAsyncReply(result:Object, exception:Object, exCallId:uint):void {
			var call:FacebookCall = externalInterfaceCalls[exCallId];
			
			if (result) {
				var data:JSONResultData = new JSONResultData();
				data.result = result;
				call.facebook_internal::handleResult(data);
			} else {
				var error:FacebookError = new FacebookError();
				error.rawResult = JSON.encode(exception);
				call.facebook_internal::handleError(error);
			}
			delete externalInterfaceCalls[exCallId];
		}
		
		protected function buildCall():String {
			var bridgeCallFunctionName:String = "bridgeFacebookCall_"+externalInterfaceCallId;
			
			RequestHelper.formatRequest(call);
			
			var objectArgs:Object = {};
			
			for (var n:String in call.args) {
				objectArgs[n] = call.args[n];
			}
			
			var jsCall:String = "function " + bridgeCallFunctionName + "() { " + 
				"FB.Facebook.apiClient.callMethod(\""+call.method+"\", "+JavascriptRequestHelper.formatURLVariables(call.args)+", " + 
						"function(result, exception) {" + 
							"document." + (_session as JSSession).as_swf_name + ".bridgeFacebookReply(result, exception, "+externalInterfaceCallId+")" + 
						"}" + 
				");" + 
			"}";
			
			return jsCall;
		}
	}
}