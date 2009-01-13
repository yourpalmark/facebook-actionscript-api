package com.pbking.facebook.session
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.delegates.DesktopDelegate;
	import com.pbking.facebook.delegates.IFacebookCallDelegate;
	import com.pbking.facebook.events.FacebookActionEvent;
	import com.pbking.util.logging.PBLogger;
	
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	[Event(name="connect", type="com.pbking.facebook.events.FacebookActionEvent")]
	[Event(name="waiting_for_login", type="com.pbking.facebook.events.FacebookActionEvent")]

	public class DesktopSession extends EventDispatcher implements IFacebookSession
	{
		protected var _auth_token:String;
		protected var _api_key:String; 
		protected var non_inf_session_secret:String;
		protected var _secret:String = '';
		protected var _session_key:String;
		protected var _uid:String;
		protected var _expires:Number;
		protected var _api_version:String = "1.0";
		protected var _is_connected:Boolean = false;
		protected var _waiting_for_login:Boolean = false;
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
		
		public function DesktopSession(api_key:String, secret:String, infinite_session_key:String=null, infinite_session_secret:String=null)
		{
			this._api_key = api_key;
			this._secret = secret;
			
			if(infinite_session_key)
			{
				this.non_inf_session_secret = secret;
				this._secret = infinite_session_secret;
				this._session_key = infinite_session_key;

				//make a call to verify our session
				logger.debug("testing infinate session");
				var call:FacebookCall = new FacebookCall("facebook.users.getLoggedInUser");
				call.addCallback(verifyInfinateSession);
				this.post(call);
			}
			else
			{
				this._secret = secret;
				createToken();
			}
		}

		// INTERFACE REQUIREMENTS //////////

		public function get is_connected():Boolean { return _is_connected; }

		public function get api_version():String { return this._api_version; }
		public function set api_version(newVal:String):void { this._api_version = newVal; }

		public function get api_key():String { return _api_key;	}
		
		public function get secret():String { return _secret; }

		public function get session_key():String { return _session_key; }

		public function get expires():Number { return _expires; }
		
		public function get uid():String { return _uid; } 
		
		public function get waiting_for_login():Boolean { return _waiting_for_login; }

		public function post(call:FacebookCall):IFacebookCallDelegate
		{
			return new DesktopDelegate(call, this);
		}
		
		// UTILITIES //////////
		
		protected function createToken():void
		{
			var call:FacebookCall = new FacebookCall("auth.createToken");
			call.addCallback(onTokenCreated);
			post(call);
		}

		protected function onTokenCreated(call:FacebookCall):void
		{
			if(call.success)
			{
				_auth_token = call.result.toString();
				
				//now that we have an auth_token we need the user to login with it
				var authenticateLoginURL:String = login_url + "?api_key="+api_key+"&v="+api_version+"&auth_token="+_auth_token;
				navigateToURL(new URLRequest(authenticateLoginURL), "_blank");
				
				this._waiting_for_login = true;
				this.dispatchEvent(new FacebookActionEvent(FacebookActionEvent.WAITING_FOR_LOGIN));
			}
			else
			{
				onConnectionError(call.errorMessage);
			}
		}
		
		/**
		 * Once a token has been created and a user has logged in we must manually 
		 * validate this session with a call to this method.  Once this has been 
		 * sucessfully called, the Facebook session is ready
		 */
		public function validateDesktopSession():void
		{
			_waiting_for_login = false;
			
			//validate the session
			var call:FacebookCall = new FacebookCall("auth.getSession");
			call.setRequestArgument("auth_token", _auth_token);
			call.addCallback(validateDesktopSessionReply);
			
			post(call);
		}
		
		protected function validateDesktopSessionReply(call:FacebookCall):void
		{
			if(call.success)
			{
				this._uid = call.result.uid;
				this._session_key = call.result.session_key;
				this._expires = call.result.expires;
				this._secret = call.result.secret;

				onReady();
			}
			else
			{
				onConnectionError(call.errorMessage);
			}
		}
		
		protected function onReady():void
		{
			_is_connected = true;
			this.dispatchEvent(new FacebookActionEvent(FacebookActionEvent.CONNECT));
		}
		
		protected function onConnectionError(message:String):void
		{
			logger.warn(message);
			_is_connected = false;
			this.dispatchEvent(new FacebookActionEvent(FacebookActionEvent.CONNECT));
		}

		protected function verifyInfinateSession(call:FacebookCall):void
		{
			if(call.success)
			{
				logger.debug("infinate session success");
				this._uid = call.result.toString();
				onReady();
			}
			else
			{
				//infinate session didn't work out.  just start over without it
				logger.warn("infinate session failed.  logging user in");
				this._session_key = null;
				this._secret = this.non_inf_session_secret;
				createToken();
			}
		}
		
	}
}