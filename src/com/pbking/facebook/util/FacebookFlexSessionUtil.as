package com.pbking.facebook.util
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.events.FacebookActionEvent;
	import com.pbking.facebook.session.DesktopSession;
	import com.pbking.facebook.session.FBJSBridgeSession;
	import com.pbking.facebook.session.JSBridgeSession;
	import com.pbking.facebook.session.WebSession;
	import com.pbking.util.logging.PBLogger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.events.CloseEvent;
	
	[Event(name="connect", type="com.pbking.facebook.events.FacebookActionEvent")]
	[Event(name="waiting_for_login", type="com.pbking.facebook.events.FacebookActionEvent")]

	public class FacebookFlexSessionUtil extends EventDispatcher
	{
		public var facebook:Facebook;
		
		public var localKeyFile:String;
		
		protected var logger:PBLogger = PBLogger.getLogger("pbking.facebook");

		protected var api_key:String;
		protected var secret:String; 
		
		// CONSTRUCTION //////////
		
		function FacebookFlexSessionUtil()
		{
			//create our facebook instance
			facebook = new Facebook();
			facebook.addEventListener(FacebookActionEvent.CONNECT, onFacebookReady);
		}
		
		// PUBLIC FUNCTIONS //////////
		
		/**
		 * initiate connection.
		 */
		public function connect(api_key:String=null, secret:String=null, localKeyFile:String="api_key_secret.xml"):void
		{
			this.localKeyFile = localKeyFile;
			this.api_key = api_key;
			this.secret = secret;

			//determine if we're running locally.  if we are we'll run this
			//app as an unsecure desktop app.  Otherwise fire up a JSAuth session
			
			var flashVars:Object = Application.application.parameters;
			
			//trace out the flashvars
			var flashVarsDebugString:String = "flashvars:\n";
			for (var s:String in flashVars)
				flashVarsDebugString += s + " = " + flashVars[s] + "\n";
			logger.debug(flashVarsDebugString);
			
			if(Application.application.url.slice(0, 5) == "file:")
			{
				logger.debug("determined a desktop application");

				if(api_key && secret)
				{
					startDesktopSession();
				}
				else
				{
					var keyLoader:URLLoader = new URLLoader();
					keyLoader.addEventListener(Event.COMPLETE, onKeySecretLoaded);
					keyLoader.load(new URLRequest(localKeyFile));
				}
			}
			else if(flashVars.fb_sig_ss && flashVars.fb_sig_api_key && flashVars.fb_sig_session_key)
			{
				logger.debug("determined an installed web application");
				facebook.startSession(new WebSession(flashVars.fb_sig_api_key, flashVars.fb_sig_ss, flashVars.fb_sig_session_key, null));
			}
			else if(flashVars.fb_sig_api_key && flashVars.fb_sig)
			{
				logger.debug("determined a not-installed web application");
				
				facebook.startSession(new WebSession(flashVars.fb_sig_api_key, null, null, flashVars.fb_sig_canvas_user));
			}
			else if(flashVars.fb_local_connection)
			{
				logger.debug("determined a fbjsBridge application (with " + flashVars.fb_local_connection + ")");
				facebook.startSession(new FBJSBridgeSession(flashVars.fb_local_connection));
			}
			else if(flashVars.as_app_name)
			{
				logger.debug("determined a jsBridge application");
				facebook.startSession(new JSBridgeSession(flashVars.as_app_name));
			}
			else
			{
				logger.fatal("could not determind facebook connection type");
				throw new Error("could not determind facebook connection type");
			}
		}
		
		// UTILS //////////
		
		/**
		 * get the stored session for the set api
		 */
		protected function getStoredSession(apiKey:String):SharedObject
		{
			return SharedObject.getLocal(apiKey+"_stored_session");
		}
		
		/**
		 * called when(if) the keyScret file is loaded
		 */
		protected function onKeySecretLoaded(e:Event):void
		{
			var keyLoader:URLLoader = e.target as URLLoader;
			keyLoader.removeEventListener(Event.COMPLETE, onKeySecretLoaded);
			
			var keySecret:XML = new XML(keyLoader.data);
			
			this.api_key = keySecret.api_key;
			this.secret = keySecret.secret;
			
			startDesktopSession();
		}
		
		protected function startDesktopSession():void
		{
			logger.debug("starting desktop session");
			
			var storedSession:SharedObject = getStoredSession(api_key);
			var session:DesktopSession = new DesktopSession(api_key, secret, storedSession.data.infinite_session_key, storedSession.data.stored_secret);
			
			session.addEventListener(FacebookActionEvent.WAITING_FOR_LOGIN, onWaitingForLogin);
			 
			facebook.startSession(session);
		}
		
		protected function onWaitingForLogin(e:FacebookActionEvent):void
		{
			this.dispatchEvent(new FacebookActionEvent(FacebookActionEvent.WAITING_FOR_LOGIN));
			
			Alert.show("A Facebook login prompt is opening in a browser window.  Login and when instructed close that window and click 'OK'.", "Facebook Login", 4, null, onLoginAlertClose);
		}
		
		protected function onLoginAlertClose(e:CloseEvent):void
		{
			facebook.validateDesktopSession();
		}
		
		/**
		 * Called with the facebook connection is ready.
		 * Saves an infiniate session key if possible
		 */
		protected function onFacebookReady(event:Event):void
		{
			if(facebook.is_connected)
			{
				//save infinate session key if we can
				if(facebook.expires == 0)
				{
					var storedSession:SharedObject = getStoredSession(api_key);

					storedSession.data.infinite_session_key = facebook.session_key;
					storedSession.data.stored_secret = facebook.secret;
					storedSession.flush();
				}

				this.dispatchEvent(new FacebookActionEvent(FacebookActionEvent.CONNECT));
			}
			else
			{
				//:(
			}
		}
	}
}