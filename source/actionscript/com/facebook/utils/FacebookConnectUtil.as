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
				call.facebook_internal::handelResult(data);
			} else {
				var error:FacebookError = new FacebookError();
				error.rawResult = exception as String;
				call.facebook_internal::handleError(error);
			}
			
			delete externalInterfaceCalls[externalInterfaceCallId];
		}
		
	}
}