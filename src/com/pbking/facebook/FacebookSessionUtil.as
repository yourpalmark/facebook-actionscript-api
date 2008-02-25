package com.pbking.facebook
{
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.core.Application;
	
	public class FacebookSessionUtil
	{
		public var facebook:Facebook;
		public var storedSession:SharedObject;
		
		function FacebookSessionUtil(localKeyFile:String="api_key_secret.xml")
		{
			//create our facebook instance
			facebook = new Facebook();
			facebook.addEventListener(Event.COMPLETE, onFacebookReady);
			
			//determine if we're running locally.  if we are we'll run this
			//app as an unsecure desktop app.  Otherwise fire up a JSAuth session
			if(Application.application.url.slice(0, 5) == "file:")
			{
				var keyLoader:URLLoader = new URLLoader();
				keyLoader.addEventListener(Event.COMPLETE, onKeySecretLoaded);
				keyLoader.load(new URLRequest(localKeyFile));
			}
			else
			{
				var flashVars:Object = Application.application.parameters;
				
				storedSession = getStoredSession(flashVars.api_key);
				
				facebook.startJSBridgeSession(flashVars.api_key, flashVars.secret, flashVars.session_key, flashVars.expires, flashVars.user_id); 
			}
		}
		
		private function getStoredSession(apiKey:String):SharedObject
		{
			return SharedObject.getLocal(apiKey+"_stored_session");
		}
		
		private function onKeySecretLoaded(e:Event):void
		{
			var keyLoader:URLLoader = e.target as URLLoader;
			keyLoader.removeEventListener(Event.COMPLETE, onKeySecretLoaded);
			
			var keySecret:XML = new XML(keyLoader.data);
			
			storedSession = getStoredSession(keySecret.api_key);
			
			facebook.startDesktopSession(keySecret.api_key, keySecret.secret, storedSession.data.infinite_session_key, storedSession.data.stored_secret);
		}
		
		/**
		 * Called with the facebook connection is ready.
		 * Makes the call to get a list of the user's albums
		 */
		private function onFacebookReady(event:Event):void
		{
			if(facebook.isConnected)
			{
				//save infinate session key if we can
				if(facebook.expires == 0)
				{
					storedSession.data.infinite_session_key = facebook.session_key;
					storedSession.data.stored_secret = facebook.secret;
					storedSession.flush();
				}
			}
			else
			{
				//:(
			}
		}
	}
}