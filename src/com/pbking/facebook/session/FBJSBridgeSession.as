package com.pbking.facebook.session
{
	import com.pbking.facebook.delegates.IFacebookCallDelegate;
	import com.pbking.facebook.FacebookCall;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.LocalConnection;
	import com.pbking.facebook.delegates.FBJSBridgeDelegate;

	public class FBJSBridgeSession extends EventDispatcher implements IFacebookSession
	{
		// VARIABLES //////////
		
		public var bridgeSwfName:String;
		
		// CONSTRUCTION //////////
		
		public function FBJSBridgeSession(bridgeSwfName:String)
		{
			this.bridgeSwfName = bridgeSwfName;
		}

		// INTERFACE METHODS //////////

		public function get is_connected():Boolean { return true; }

		public function get is_sessionless():Boolean { return true; }
		
		public function get waiting_for_login():Boolean { return true; }
		
		public function get api_key():String
		{
			return null;
		}
		
		public function get secret():String
		{
			return null;
		}
		
		public function get session_key():String
		{
			return null;
		}
		
		public function get expires():Number
		{
			return 0;
		}
		
		public function get uid():String
		{
			return null;
		}
		
		public function get api_version():String
		{
			return null;
		}
		
		public function post(call:FacebookCall):IFacebookCallDelegate
		{
			return new FBJSBridgeDelegate(call, this);
		}
		
	}
}