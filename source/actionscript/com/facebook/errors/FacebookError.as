/**
 * DTO that defines a returned error from the Facebook API.
 * 
 */
package com.facebook.errors {
	
	import flash.events.ErrorEvent;
	import flash.net.URLVariables;
	
	public class FacebookError {
		
		public var error:Error;
		public var errorEvent:ErrorEvent;
		public var rawResult:String;
		public var reason:String;
		
		//Data returned from the Service
		public var errorCode:Number;
		public var errorMsg:String;
		public var requestArgs:URLVariables;
		
		
		public function FacebookError() {
			
		}

	}
}