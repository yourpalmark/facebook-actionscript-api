package com.pbking.facebook.session
{
	import com.pbking.facebook.FacebookCall;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.controls.HTML;
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
	public class AirSession extends DesktopSession
	{
		protected var htmlWindow:HTML;
		
		public function AirSession(api_key:String, secret:String, infinite_session_key:String=null, infinite_session_secret:String=null)
		{
			super(api_key, secret, infinite_session_key, infinite_session_secret);
		}
		
		override protected function onTokenCreated(call:FacebookCall):void
		{
			if(call.success)
			{
				_auth_token = call.result.toString();
				var authenticateLoginURL:String = login_url + "?api_key="+api_key+"&v="+api_version+"&auth_token="+_auth_token;
				
				htmlWindow = new HTML();
				htmlWindow.width = Application.application.width;
				htmlWindow.height = Application.application.height;
				
				htmlWindow.location = authenticateLoginURL;
				htmlWindow.reload();
				
				htmlWindow.addEventListener(Event.LOCATION_CHANGE, onLocationChange);
				
				PopUpManager.addPopUp(htmlWindow, DisplayObject(Application.application), true);
				PopUpManager.centerPopUp(htmlWindow);
			}
			else
			{
				onConnectionError(call.errorMessage);
			}
		}
		
        private function onLocationChange(e:Event):void
        {
            trace("change");
            
            var location:String = htmlWindow.location;
            
            trace(location);
            
            var pattern:RegExp = /api_key/i;

            if (location.search(pattern) != -1)
            {
            	PopUpManager.removePopUp(htmlWindow);
            	htmlWindow=null;
                validateDesktopSession();
            }
        }
		
	}
}