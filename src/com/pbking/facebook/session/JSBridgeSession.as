package com.pbking.facebook.session
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.delegates.IFacebookCallDelegate;
	import com.pbking.facebook.delegates.JSBridgeDelegate;
	
	import flash.external.ExternalInterface;
	import flash.events.EventDispatcher;
	
	public class JSBridgeSession extends EventDispatcher implements IFacebookSession
	{
		// VARIABLES //////////
		
		public var as_app_name:String;
		
		private var _api_version:String = "1.0";
		
		// CONSTRUCTION //////////
		
		public function JSBridgeSession(as_app_name:String)
		{
			this.as_app_name = as_app_name;

		}

		// INTERFACE IMPLEMENTATION //////////

		public function get is_connected():Boolean { return true; }
		public function get waiting_for_login():Boolean { return false; }

		public function get api_version():String { return this._api_version; }
		public function set api_version(newVal:String):void { this._api_version = newVal; }

		public function post(call:FacebookCall):IFacebookCallDelegate
		{
			return new JSBridgeDelegate(call, this);
		}
		
		// We're just reaching into the JS API and are sync calls

		public function get api_key():String 
		{
			var call:String = "function(){return FB.Facebook.apiClient.get_apiKey();}";	
			return ExternalInterface.call(call);
        }

		public function get session_key():String 
		{
			var call:String = "function(){return FB.Facebook.apiClient.get_session().session_key;}";	
			return ExternalInterface.call(call);
        }		
		
		public function get expires():Number 
		{
			var call:String = "function(){return FB.Facebook.apiClient.get_session().expires;}";	
			return ExternalInterface.call(call);
        }		
	
		public function get secret():String 
		{
			var call:String = "function(){return FB.Facebook.apiClient.get_session().secret;}";	
			return ExternalInterface.call(call);
        }		
	
		public function get uid():String 
		{
			var call:String = "function(){return FB.Facebook.apiClient.get_session().uid;}";	
			return ExternalInterface.call(call);
        }

		// UTILITIES //////////

		public function get sig():String 
		{
			var call:String = "function(){return FB.Facebook.apiClient.get_session().sig;}";	
			return ExternalInterface.call(call);
        }
		
	}
}