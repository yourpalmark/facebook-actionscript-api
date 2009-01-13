package com.pbking.facebook
{
	import com.pbking.facebook.session.AirSession;
	
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class FacebookAirSessionUtil extends FacebookSessionUtil 
	{
		function FacebookAirSessionUtil()
		{
			super();
		}
		
		override public function connect(api_key:String=null, secret:String=null, localKeyFile:String="api_key_secret.xml"):void
		{
			if(api_key && secret)
			{
				this.api_key = api_key;
				this.secret = secret;
				
				startDesktopSession();
			}
			else
			{
				var keyLoader:URLLoader = new URLLoader();
				keyLoader.addEventListener(Event.COMPLETE, onKeySecretLoaded);
				keyLoader.load(new URLRequest(localKeyFile));
			}
		}
		
		
		override protected function startDesktopSession():void
		{
			var storedSession:SharedObject = getStoredSession(api_key);
			facebook.startSession(new AirSession(api_key, secret, storedSession.data.infinite_session_key, storedSession.data.stored_secret));
		}
		
	}
}