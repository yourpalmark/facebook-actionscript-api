package com.pbking.facebook.session
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.delegates.DesktopDelegate;
	import com.pbking.facebook.delegates.IFacebookCallDelegate;
	import com.pbking.facebook.events.FacebookActionEvent;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	[Event(name="connect", type="com.pbking.facebook.events.FacebookActionEvent")]
	[Event(name="connection_error", type="com.pbking.facebook.events.FacebookActionEvent")]
	[Event(name="waiting_for_login", type="com.pbking.facebook.events.FacebookActionEvent")]

	public class DesktopSession extends WebSession implements IFacebookSession
	{
		protected var _auth_token:String;
		protected var non_inf_session_secret:String;
		protected var _waiting_for_login:Boolean = false;

		private var infinite_session_key:String;
		private var infinite_session_secret:String;

		// CONSTRUCTION //////////

		public function DesktopSession(api_key:String, secret:String, infinite_session_key:String=null, infinite_session_secret:String=null)
		{
			this.infinite_session_key = infinite_session_key;
			this.infinite_session_secret = infinite_session_secret;
			
			super(api_key, secret, null, null);
		}
		
		override protected function initConnection():void
		{
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

		override public function get waiting_for_login():Boolean { return _waiting_for_login; }

		override public function post(call:FacebookCall):IFacebookCallDelegate
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