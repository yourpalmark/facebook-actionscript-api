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
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.auth.*;
	import com.pbking.facebook.delegates.users.GetLoggedInUserDelegate;
	import com.pbking.facebook.events.FacebookActionEvent;
	import com.pbking.facebook.methodGroups.*;
	import com.pbking.util.logging.PBLogger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	[Event(name="complete", type="com.pbking.facebook.events.FacebookActionEvent")]
	[Event(name="waiting_for_login", type="com.pbking.facebook.events.FacebookActionEvent")]

	[Bindable]
	public class Facebook extends EventDispatcher
	{	
		// VARIABLES //////////
		
		protected var logger:PBLogger = PBLogger.getLogger("pbking.facebook");
		
		protected var _auth_token:String;
		
		/**
		 * The URL of the REST server that you will be using.
		 * Change this if you are using a redirect server.
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
		
		function Facebook():void
		{
			//nothing here
		}
		
		// GETTERS and SETTERS //////////
		
		/**
		 * The "api_key" associated with your application and provided by Facebook.
		 */
		protected var _api_key:String; 
		public function get api_key():String { return _api_key;	}
		
		/**
		 * The "secret" associated with your application and provided by Facebook.
		 */
		protected var _secret:String = '';
		public function get secret():String { return _secret; }
		
		protected var _fb_js_api_name:String;
		public function get fb_js_api_name():String { return _fb_js_api_name; }
		
		protected var _as_app_name:String;
		public function get as_app_name():String { return _as_app_name; }

		/**
		 * The session type.  It could be DESKTOP, WEB, or JAVASCRIPT_BRIDGE depending on the type of session that was started.
		 * There IS a setter for binding purposes but this value IS NOT SETTABLE.
		 */
		protected var _sessionType:String;
		public function get sessionType():String { return this._sessionType; }
		public function set sessionType(newVal:String):void {/*for binding*/}
		protected function setSessionType(newVal:String):void
		{
			this._sessionType = newVal;
			//ping setter to execute bindings
			this.sessionType = null; 
		}
		
		
		/**
		 * Facebook namespace to use when pulling out XML data responses
		 */
		protected var _facebook_namespace:Namespace;
		public function get FACEBOOK_NAMESPACE():Namespace
		{
			if(_facebook_namespace == null)
			{
				_facebook_namespace = new Namespace("http://api.facebook.com/1.0/");
			}
			return _facebook_namespace;
		}
		
		/** 
		 * session key 
		 */
		public function set session_key(newVal:String):void { this._session_key = newVal; }
		public function get session_key():String { return _session_key; }
		protected var _session_key:String;
		
		/** 
		 * logged in user
		 */
		public function get user():FacebookUser 
		{ 
			if(!_user)
			{
				_user = new FacebookUser(-1);
				_user.isLoggedInUser = true;
			}
			return _user; 
		}
		protected var _user:FacebookUser;
		
		/**
		 * connection time
		 */
		public function get time():Number 
		{
			if(_time == 0)
			{
				_time = new Date().time/1000;
			}
			return _time; 
		}
		protected var _time:Number = 0;
		
		/**
		 * The time the session will expire.
		 * 0 if it doesn't expire
		 */
		public function get expires():Number { return _expires; }
		protected var _expires:Number = 0;
		
		/**
		 * Returns true when the connection has been established and we are ready to make calls
		 * There IS a setter for binding purposes but this value IS NOT SETTABLE.
		 */
		public function get isConnected():Boolean { return this._isConnected; }
		public function set isConnected(newVal:Boolean):void {/*for binding*/}
		protected var _isConnected:Boolean = false;
		protected function setIsConnected(newVal:Boolean):void
		{
			_isConnected = newVal;
			isConnected = !newVal; //ping to promote binding
		}
		
		/**
		 * Version of the facebook API.  This will be updated as the API is updated, but you can
		 * change it to use beta features, etc
		 */
		protected var _api_version:String = "1.0";
		public function get api_version():String { return this._api_version; }
		public function set api_version(newVal:String):void { this._api_version = newVal };
		
		protected var _connectionErrorMessage:String;
		public function get connectionErrorMessage():String { return _connectionErrorMessage; }
		
		// METHOD GROUPS //////////
		
		protected var _photos:Photos;
		public function get photos():Photos 
		{ 
			if(!_photos)
				_photos = new Photos(this)
			return this._photos; 
		}
		
		protected var _friends:Friends;
		public function get friends():Friends 
		{ 
			if(!_friends)
				_friends = new Friends(this)
			return this._friends; 
		}
		
		protected var _users:Users;
		public function get users():Users 
		{ 
			if(!_users)
				_users = new Users(this)
			return this._users; 
		}
		
		protected var _events:Events;
		public function get events():Events 
		{ 
			if(!_events)
				_events = new Events(this)
			return this._events; 
		}
		
		protected var _feed:Feed;
		public function get feed():Feed 
		{ 
			if(!_feed)
				_feed = new Feed(this)
			return this._feed; 
		}
		
		protected var _fql:Fql;
		public function get fql():Fql 
		{ 
			if(!_fql)
				_fql = new Fql(this)
			return this._fql; 
		}
		
		protected var _groups:Groups;
		public function get groups():Groups 
		{ 
			if(!_groups)
				_groups = new Groups(this)
			return this._groups; 
		}
		
		protected var _marketplace:Marketplace;
		public function get marketplace():Marketplace 
		{ 
			if(!_marketplace)
				_marketplace = new Marketplace(this)
			return this._marketplace; 
		}
		
		protected var _notifications:Notifications;
		public function get notifications():Notifications 
		{ 
			if(!_notifications)
				_notifications = new Notifications(this)
			return this._notifications; 
		}
		
		protected var _pages:Pages;
		public function get pages():Pages 
		{ 
			if(!_pages)
				_pages = new Pages(this)
			return this._pages; 
		}
		
		protected var _profile:Profile;
		public function get profile():Profile 
		{ 
			if(!_profile)
				_profile = new Profile(this)
			return this._profile; 
		}
		
		// SESSION FUNCTIONS //////////

		public function startJSBridgeSession( api_key:String, 
											  secret:String, 
											  session_key:String, 
											  expires:Number, 
											  user_id:Number, 
											  fb_js_api_name:String, 
											  as_app_name:String):void
		{
			logger.debug("starting jsBridge session");
			
			setSessionType(FacebookSessionType.JAVASCRIPT_BRIDGE);
			
			this._fb_js_api_name = fb_js_api_name;
			this._as_app_name = as_app_name;
			
			this._api_key = api_key;
			this._secret = secret;
			this._session_key = session_key;
			this._expires = expires;

			this._user = FacebookUser.getUser(user_id);

			if (_api_key == "" || _api_key == null)
			{
				onConnectionError("Incorrect api_key passed to startJSBridgeSession()");
				return;
			}
			
			if (_session_key == "" || _session_key == null)
			{
				onConnectionError("Incorrect session_key passed to startJSBridgeSession()");
				return;
			}
			
			if (this._fb_js_api_name == "" || this._fb_js_api_name == null)
			{
				onConnectionError("Incorrect Facebook JavaScript API name passed to startJSBridgeSession()");
				return;
			}
			
			onReady();
		}
		
		/**
		 * For testing purposes
		 */
		public function startNoSession(api_key:String, secret:String):void
		{
			this._api_key = api_key;
			this._secret = secret;
		}

		protected var non_inf_session_secret:String;
		/**
		 * Start a session for a desktop based application.
		 * For this you need to know and pass the application api_key and secret.
		 * The user will be prompted to login to their Facebook page after which you should call
		 * validateDesktopSession().  Alternately you could pass in an infinite_session_key which
		 * will authenticate immediately (without navigating to the user login page).
		 */
		public function startDesktopSession(api_key:String, secret:String, infinite_session_key:String=null, infinite_session_secret:String=null):void
		{
			logger.debug("starting desktop session");

			setSessionType(FacebookSessionType.DESKTOP);
			
			this._sessionType = FacebookSessionType.DESKTOP;
			this.sessionType = _sessionType;
			
			this._api_key = api_key;
			
			if(infinite_session_key)
			{
				this.non_inf_session_secret = secret;
				this._secret = infinite_session_secret;
				this._session_key = infinite_session_key;

				//make a call to verify our session (and grab our user while we're at it)
				this.users.getLoggedInUser(verifyInfinateSession);
			}
			else
			{
				this._secret = secret;
				//construct a token and get ready for the user to enter user/pass
				var delegate:CreateTokenDelegate = new CreateTokenDelegate(this);
				delegate.addEventListener(Event.COMPLETE, onDesktopTokenCreated);
			}
		}
		
		protected function verifyInfinateSession(event:Event):void
		{
			var d:GetLoggedInUserDelegate = event.target as GetLoggedInUserDelegate;
			if(d.success)
			{
				this._user = d.user;
				this._user.isLoggedInUser = true;
				onReady();
			}
			else
			{
				//infinate session didn't work out.  just start over without it
				this.session_key = null;
				this._secret = this.non_inf_session_secret;
				startDesktopSession(this._api_key, this._secret);
			}
		}
		
		protected function onDesktopTokenCreated(event:Event):void
		{
			var delegate:CreateTokenDelegate = event.target as CreateTokenDelegate;
			if(delegate.success)
			{
				_auth_token = delegate.auth_token;
				
				//now that we have an auth_token we need the user to login with it
				var authenticateLoginURL:String = login_url + "?api_key="+api_key+"&v=1.0&auth_token="+_auth_token;
				navigateToURL(new URLRequest(authenticateLoginURL), "_blank");
				
				this.dispatchEvent(new FacebookActionEvent(FacebookActionEvent.WAITING_FOR_LOGIN));
			}
			else
			{
				onConnectionError(delegate.errorMessage);
			}
		}
		
		/**
		 * Once a token has been created and a user has logged in we must manually validate this session
		 * with a call to this method.  Once this has been sucessfully called, the Facebook session is ready
		 */
		public function validateDesktopSession():void
		{
			//validate the session
			var delegate:GetSessionDelegate = new GetSessionDelegate(this, _auth_token);
			delegate.addEventListener(Event.COMPLETE, validateDesktopSessionReply);
		}
		
		protected function validateDesktopSessionReply(event:Event):void
		{
			var delegate:GetSessionDelegate = event.target as GetSessionDelegate;
			if(delegate.success)
			{
				this._user = FacebookUser.getUser(delegate.uid);
				this._user.isLoggedInUser = true;

				this._session_key = delegate.session_key;
				this._expires = delegate.expires;
				this._secret = delegate.secret;
			
				onReady();
			}
			else
			{
				onConnectionError(delegate.errorMessage);
			}
		}
		
		/**
		 * Start a session for a Facebook widget application.
		 * This method is not secure and has been depreciated!  
		 * Instead please use startJSBridgeSession.
		 */
		public function startWidgetSession(flashVars:Object, api_key:String, secret:String):void
		{
			logger.debug("starting facebook widget session");
			logger.warn("START WIDGET SESSION HAS BEEN DEPRECIATED!  USE .startJSAuthSession INSTEAD!");
			
			setSessionType(FacebookSessionType.WEB);
			this._secret = secret;
			this._api_key = api_key;
			
			//save the information of those props into our class vars for use in the app
			this._user = FacebookUser.getUser(parseInt(flashVars['fb_sig_user']));
			this._user.isLoggedInUser = true;
			
			this._time = flashVars['fb_sig_time'];
			
			this._expires = flashVars['fb_sig_expires'];
			
			if(this._session_key == null)
				this._session_key = flashVars['fb_sig_session_key'];
			
			if(session_key)
				onReady();
			else
				onConnectionError("No session key set for session");
		}
		
		/**
		 * Helper function.  Called when the connection is ready.
		 */
		protected function onReady():void
		{
			setIsConnected(true);
			dispatchEvent(new FacebookActionEvent(FacebookActionEvent.COMPLETE));
		}
		
		/**
		 * Helper function.  Called when the connection fails to be made.
		 */
		protected function onConnectionError(errorMessage:String):void
		{
			setIsConnected(false);
			_connectionErrorMessage = errorMessage;
			logger.fatal(errorMessage);
			dispatchEvent(new FacebookActionEvent(FacebookActionEvent.COMPLETE));
		}
		
	}
}