package com.facebook.utils {
	
	import com.facebook.data.FBJSData;
	import com.facebook.events.FacebookEvent;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	public class FBJSBridgeUtil extends EventDispatcher {
		
		protected static var connection:LocalConnection;
		protected static var receiveConnection:LocalConnection;
		
		public var _api_key:String;
		public var fb_local_connection:String;
		public var fb_fbjs_connection:String;
		
		protected var _methodName:String;
		protected var _params:Array;
		
		public function FBJSBridgeUtil(api_key:String, fb_local_connection:String, fb_fbjs_connection:String) {
			this._api_key = api_key;
			this.fb_local_connection = fb_local_connection;
			this.fb_fbjs_connection = fb_fbjs_connection;
			
			if (connection == null) {
				connection = new LocalConnection();
				connection.allowInsecureDomain('*');
				connection.allowDomain('*');
				connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onSendError, false, 0, true);
				connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSendError, false, 0, true);
				connection.addEventListener(StatusEvent.STATUS, onSendStatus, false, 0, true);
			}
			
			if (receiveConnection == null) {
				receiveConnection = new LocalConnection();
				receiveConnection.allowInsecureDomain('*');
				receiveConnection.allowDomain('*');
				receiveConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onReceiveError, false, 0, true);
				receiveConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onReceiveError, false, 0, true);
				receiveConnection.addEventListener(StatusEvent.STATUS, onReceiveStatus, false, 0, true);
				receiveConnection.client = {asFunction:function(...rest) { asFunction(rest); }};
    			
				try {
					receiveConnection.connect(fb_fbjs_connection);
				} catch (e:*) {
					//
				}
			}
		}
		
		public function call(methodName:String, ...params:Array):void {
			_methodName = methodName;
			_params = params;
			execute();
		}
		
		protected function asFunction(params:Array):void {
			var data:FBJSData = new FBJSData();
			data.results = params;
			
			dispatchEvent(new FacebookEvent(FacebookEvent.COMPLETE, false, false, true, data));
		}
		
		protected function onSendStatus(event:StatusEvent):void {
			dispatchEvent(event);
		}
		
		protected function onSendError(event:ErrorEvent):void {
			dispatchEvent(event);
		}
		
		protected function onReceiveError(event:ErrorEvent):void {
			dispatchEvent(event);
		}
		
		protected function onReceiveStatus(event:StatusEvent):void {
			dispatchEvent(event);
		}
		
		public function close():void {
			try {
				connection.close();
			} catch (e:*) { }
			
			try {
				receiveConnection.close();
			} catch (e:*) { }
		}
		
		protected function execute():void {
			connection.send(fb_local_connection, "callFBJS", _methodName, _params);
		}
	}
}