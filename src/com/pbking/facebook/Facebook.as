/*
Copyright (c) 2007 Jason Crist

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

/**
 * Facebook API top level class. 
 * 
 * Provides internal configuration, connection management, and abstract method exposure.
 * 
 * @see http://developers.facebook.com/documentation.php?v=1.0
 * @author Jason Crist 
 */

package com.pbking.facebook
{
	import com.pbking.facebook.delegates.IFacebookCallDelegate;
	import com.pbking.facebook.events.FacebookActionEvent;
	import com.pbking.facebook.session.DesktopSession;
	import com.pbking.facebook.session.IFacebookSession;
	import com.pbking.util.logging.PBLogger;
	
	import flash.events.EventDispatcher;
	
	[Event(name="connect", type="com.pbking.facebook.events.FacebookActionEvent")]
	[Event(name="waiting_for_login", type="com.pbking.facebook.events.FacebookActionEvent")]

	[Bindable]
	public class Facebook extends EventDispatcher
	{	
		// VARIABLES //////////
		
		public var logger:PBLogger = PBLogger.getLogger("pbking.facebook");
		public var connectionErrorMessage:String;
		public var waiting_for_login:Boolean;

		protected static var _facebook_namespace:Namespace;
		
		private var _currentSession:IFacebookSession;
		
		// CONSTRUCTION //////////
		
		function Facebook():void
		{
			//nothing here
		}
		
		// GETTERS and SETTERS //////////
		
		public function get is_connected():Boolean 
		{ return _currentSession ? this._currentSession.is_connected : false; }
		
		public function get api_key():String 
		{ return _currentSession ? this._currentSession.api_key : null; }

		public function get secret():String 
		{ return _currentSession ? this._currentSession.secret : null; } 
	
		public function get session_key():String 
		{ return _currentSession ? this._currentSession.session_key : null; }
		
		public function get expires():Number 
		{ return _currentSession ? this._currentSession.expires : -1; }
	
		public function get uid():String 
		{ return _currentSession ? this._currentSession.uid : null; }

		public function get api_version():String 
		{ return _currentSession ? this._currentSession.api_version : null; }

		/**
		 * Facebook namespace to use when pulling out XML data responses
		 */
		public static function get FACEBOOK_NAMESPACE():Namespace
		{
			if(_facebook_namespace == null)
			{
				_facebook_namespace = new Namespace("http://api.facebook.com/1.0/");
			}
			return _facebook_namespace;
		}
		
		public function startSession(session:IFacebookSession):void
		{
			_currentSession = session;
			
			if(_currentSession.is_connected)
			{
				dispatchEvent(new FacebookActionEvent(FacebookActionEvent.CONNECT));
			}
			else
			{
				_currentSession.addEventListener(FacebookActionEvent.CONNECT, onSessionConnected);
				_currentSession.addEventListener(FacebookActionEvent.WAITING_FOR_LOGIN, onWaitingForLogin);
			}
		}
		
		public function post(call:FacebookCall, callback:Function=null):IFacebookCallDelegate
		{
			if(_currentSession)
			{
				call.facebook = this;
				call.initialize();
			
				if(callback != null)
					call.addCallback(callback);
					
				return _currentSession.post(call);
			}
			else
			{
				throw new Error("cannot post a call; no session has been set");
			}
			
			return null;
		}
		
		public function validateDesktopSession():void
		{
			if(!is_connected && 
				_currentSession is DesktopSession && 
				DesktopSession(_currentSession).waiting_for_login)
			{
				DesktopSession(_currentSession).validateDesktopSession();
			}
		}
		
		// UTILS //////////
		
		/**
		 * Helper function.  Called when the connection is ready.
		 */
		protected function onSessionConnected(e:FacebookActionEvent):void
		{
			var session:IFacebookSession = e.target as IFacebookSession;
			
			dispatchEvent(new FacebookActionEvent(FacebookActionEvent.CONNECT));
		}
		
		protected function onWaitingForLogin(e:FacebookActionEvent):void
		{
			waiting_for_login = true;
			dispatchEvent(new FacebookActionEvent(FacebookActionEvent.WAITING_FOR_LOGIN));
		}
		
	}
}