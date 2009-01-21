package com.pbking.facebook.session
{
	import flash.events.IEventDispatcher;
	import com.pbking.facebook.delegates.IFacebookCallDelegate;
	import com.pbking.facebook.FacebookCall;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import com.pbking.facebook.delegates.WebDelegate;
	import com.pbking.util.logging.PBLogger;

	public class WebSession extends EventDispatcher implements IFacebookSession
	{
		// VARIABLES //////////
		
		protected var _api_key:String; 
		protected var _secret:String = '';
		protected var _session_key:String;
		protected var _uid:String;
		protected var _expires:Number;
		protected var _api_version:String = "1.0";
		protected var logger:PBLogger = PBLogger.getLogger("pbking.facebook");

		/**
		 * The URL of the REST server that you will be using.
		 * Change this if you are using a redirect server. (not recommended)
		 */
		public var rest_url:String = "http://api.facebook.com/restserver.php";

		/**
		 * This ACTUAL FACEBOOK rest URL.  This cannot be changed.
		 */
		public var default_rest_url:String = "http://api.facebook.com/restserver.php";

		/**
		 * The URL of the login page a user will be directed to (for desktop applications)
		 * The default will work fine but you can set it to something else.
		 */
		public var login_url:String = "http://www.facebook.com/login.php";

		// CONSTRUCTION //////////

		public function WebSession(api_key:String, secret:String, session_key:String)
		{
			super();
			
			this._api_key = api_key;
			this._secret = secret;
			this._session_key = session_key;
		}
		
		// INTERFACE REQUIREMENTS //////////

		public function get is_connected():Boolean { return true; }

		public function get api_version():String { return this._api_version; }
		public function set api_version(newVal:String):void { this._api_version = newVal; }

		public function get api_key():String { return _api_key;	}
		
		public function get secret():String { return _secret; }

		public function get session_key():String { return _session_key; }

		public function get expires():Number { return _expires; }
		
		public function get uid():String { return _uid; } 
		
		public function get waiting_for_login():Boolean { return false; }

		public function post(call:FacebookCall):IFacebookCallDelegate
		{
			return new WebDelegate(call, this);
		}
		
	}
}