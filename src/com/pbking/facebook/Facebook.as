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
 * @author Chris Hill
 */

package com.pbking.facebook
{
	import com.gsolo.encryption.MD5;
	import com.pbking.facebook.data.events.FacebookEvent;
	import com.pbking.facebook.data.groups.FacebookGroup;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.auth.*;
	import com.pbking.facebook.methodGroups.*;
	import com.pbking.util.collection.HashableArray;
	import com.pbking.util.logging.PBLogger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	[Event(name="complete", type="flash.events.Event")]

	[Bindable]
	public class Facebook extends EventDispatcher
	{	
		// VARIABLES //////////
		
		private var logger:PBLogger = PBLogger.getLogger("pbking.facebook");
		
		private var _userCollection:HashableArray = new HashableArray('uid', false);
		private var _groupCollection:HashableArray = new HashableArray('gid', false);
		private var _eventCollection:HashableArray = new HashableArray('eid', false);
		
		public var fb_sig_values:Object;
		
		private var _auth_token:String;
		
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
		
		private static var _instance:Facebook;
		public static function get instance():Facebook
		{
			if(!_instance)
				_instance = new Facebook();
			return _instance;
		}
		
		function Facebook():void
		{
			if(Facebook._instance)
			{
				throw new Error("Only once instance of the Facebook object should be created!  The preferred way to access the Facebook object is by Facebook.instance");
			}
			_instance = this;
		}
		
		// GETTERS and SETTERS //////////
		
		/**
		 * The "api_key" associated with your application and provided by Facebook.
		 */
		private var _api_key:String; 
		public function get api_key():String { return _api_key;	}
		
		/**
		 * The "secret" associated with your application and provided by Facebook.
		 */
		private var _secret:String = '';
		public function get secret():String { return _secret; }
		
		/**
		 * Facebook namespace to use when pulling out XML data responses
		 */
		private var _facebook_namespace:Namespace;
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
		private var _session_key:String;
		public function set session_key(newVal:String):void { this._session_key = newVal; }
		public function get session_key():String { return _session_key; }
		
		/** 
		 * logged in user
		 */
		private var _user:FacebookUser;
		public function get user():FacebookUser 
		{ 
			if(!_user)
			{
				_user = new FacebookUser(-1);
				_user.isLoggedInUser = true;
			}
			return _user; 
		}
		
		/**
		 * The user whos page is being viewed.
		 * If no profile is set, the logged in user is returned
		 */
		private var _currentProfile:FacebookUser;
		public function get currentProfile():FacebookUser
		{
			if(!_currentProfile)
				return user;
			else
				return _currentProfile;
		}
		
		/** 
		 * Returns true if user is viewing their own profile
		 */ 
		public function get isUsersProfile():Boolean 
		{ 
			return this.currentProfile == this.user;
		}
		
		/**
		 * connection time
		 */
		private var _time:Number = 0;
		public function get time():Number 
		{
			if(_time == 0)
			{
				_time = new Date().time/1000;
			}
			return _time; 
		}
		
		/**
		 * The time the session will expire.
		 * 0 if it doesn't expire
		 */
		private var _expires:Number = 0;
		public function get expires():Number { return _expires; }
		
		/**
		 * The type of application that is running.
		 * Options are WEB_APP, DESKTOP_APP, WIDGET_APP.
		 * Defined in the class FacebookSessionType
		 */
		private var _sessionType:String = FacebookSessionType.WIDGET_APP;
		public function get sessionType():String { return _sessionType; }
		public function set sessionType(newVal:String):void { _sessionType = newVal; }
		
		/**
		 * Set this to true if you will be using a "redirect" server to forward your requests to the Facebook API.
		 * Using a redirect server is much more secure (your secret won't be compiled into your .swf).
		 * The service post will be constructed differently (as the sig will be constructed by your redirect server).
		 */
		private var _useRedirectServer:Boolean;
		public function get useRedirectServer():Boolean { return _useRedirectServer; }
		public function set useRedirectServer(newVal:Boolean):void { this._useRedirectServer = newVal; }
		
		
		/**
		 * Returns true when the connection has been established and we are ready to make calls
		 */
		private var _isConnected:Boolean = false;
		public function get isConnected():Boolean { return this._isConnected; }
		
		/**
		 * Version of the facebook API.  This will be updated as the API is updated, but you can
		 * change it to use beta features, etc
		 */
		private var _api_version:String = "1.0";
		public function get api_version():String { return this._api_version; }
		public function set api_version(newVal:String):void { this._api_version = newVal };
		
		// METHOD GROUPS //////////
		
		private var _photos:Photos;
		public function get photos():Photos 
		{ 
			if(!_photos)
				_photos = new Photos()
			return this._photos; 
		}
		
		private var _friends:Friends;
		public function get friends():Friends 
		{ 
			if(!_friends)
				_friends = new Friends()
			return this._friends; 
		}
		
		private var _users:Users;
		public function get users():Users 
		{ 
			if(!_users)
				_users = new Users()
			return this._users; 
		}
		
		private var _events:Events;
		public function get events():Events 
		{ 
			if(!_events)
				_events = new Events()
			return this._events; 
		}
		
		private var _feed:Feed;
		public function get feed():Feed 
		{ 
			if(!_feed)
				_feed = new Feed()
			return this._feed; 
		}
		
		private var _fql:Fql;
		public function get fql():Fql 
		{ 
			if(!_fql)
				_fql = new Fql()
			return this._fql; 
		}
		
		private var _groups:Groups;
		public function get groups():Groups 
		{ 
			if(!_groups)
				_groups = new Groups()
			return this._groups; 
		}
		
		private var _marketplace:Marketplace;
		public function get marketplace():Marketplace 
		{ 
			if(!_marketplace)
				_marketplace = new Marketplace()
			return this._marketplace; 
		}
		
		private var _notifications:Notifications;
		public function get notifications():Notifications 
		{ 
			if(!_notifications)
				_notifications = new Notifications()
			return this._notifications; 
		}
		
		/*
		Removed until the pages delegates have been created. -jc
		private var _pages:Pages;
		public function get pages():Pages 
		{ 
			if(!_pages)
				_pages = new Pages()
			return this._pages; 
		}
		*/
		
		private var _profile:Profile;
		public function get profile():Profile 
		{ 
			if(!_profile)
				_profile = new Profile()
			return this._profile; 
		}
		
		private var _connectionErrorMessage:String;
		public function get connectionErrorMessage():String { return _connectionErrorMessage; }
		
		// SESSION FUNCTIONS //////////

		/**
		 * For testing purposes
		 */
		public function startNoSession(api_key:String, secret:String):void
		{
			this._api_key = api_key;
			this._secret = secret;
		}

		/**
		 * Start a session for a web-based application.
		 * You can choose not to pass in your secret if you plan on using a proxy server
		 * for your facebook calls.  If your api_key is set here and is also passed in via 
		 * flashvars then that that value will be ignored.
		 */
		public function startWebSession(flashVars:Object, api_key:String=null, secret:String=null):void
		{
			if(secret)
				this._secret = secret;
				
			if(api_key)
				this._api_key = api_key;
				
			sessionType = FacebookSessionType.WEB_APP;
			
			//pull the auth_token (which should have been sent in as a flashvar)
			_auth_token = flashVars["auth_token"];
			
			//validate the session
			var delegate:GetSession_delegate = new GetSession_delegate(_auth_token);
			delegate.addEventListener(Event.COMPLETE, startWebSessionReply);
		}

		private function startWebSessionReply(event:Event):void
		{
			var delegate:GetSession_delegate = event.target as GetSession_delegate;
			if(delegate.success)
			{
				this._user = getUser(delegate.uid);
				this._user.isLoggedInUser = true;
				
				this._secret = delegate.secret;
				this._session_key = delegate.session_key;
				this._expires = delegate.expires;
				
				prepareSigValues();
				onReady();
			}
			else
			{
				onConnectionError(delegate.errorMessage);
			}
		}
		
		/**
		 * Start a session for a desktop based application.
		 * For this you need to know and pass the application api_key and secret.
		 * The user will be prompted to login to their Facebook page after which you should call
		 * validateDesktopSession().  Alternately you could pass in an infinite_session_key which
		 * will authenticate immediately (without navigating to the user login page).
		 */
		public function startDesktopSession(api_key:String, secret:String, infinite_session_key:String=""):void
		{
			logger.debug("starting desktop session");
			
			this._api_key = api_key;
			this._secret = secret;
			
			sessionType = FacebookSessionType.DESKTOP_APP;
			
			if(infinite_session_key != "")
			{
				//TODO: we need to do some error checking on the infinite_session_key

				this._session_key = infinite_session_key;

				// The user id is everything after the hyphen in the session key
				var i:Number = infinite_session_key.indexOf("-");
				var userid:int = parseInt(infinite_session_key.substring(i+1));
				this._user = getUser(userid);
				this._user.isLoggedInUser = true;

				prepareSigValues();
				onReady();
			}
			else
			{
				//construct a token and get ready for the user to enter user/pass
				var delegate:CreateToken_delegate = new CreateToken_delegate();
				delegate.addEventListener(Event.COMPLETE, onDesktopTokenCreated);
			}
		}
		
		private function onDesktopTokenCreated(event:Event):void
		{
			var delegate:CreateToken_delegate = event.target as CreateToken_delegate;
			if(delegate.success)
			{
				_auth_token = delegate.auth_token;
				
				//now that we have an auth_token we need the user to login with it
				var authenticateLoginURL:String = login_url + "?api_key="+api_key+"&v=1.0&auth_token="+_auth_token;
				navigateToURL(new URLRequest(authenticateLoginURL), "_blank");
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
			var delegate:GetSession_delegate = new GetSession_delegate(_auth_token);
			delegate.addEventListener(Event.COMPLETE, validateDesktopSessionReply);
		}
		
		private function validateDesktopSessionReply(event:Event):void
		{
			var delegate:GetSession_delegate = event.target as GetSession_delegate;
			
			if(delegate.success)
			{
				this._user = getUser(delegate.uid);
				this._user.isLoggedInUser = true;

				this._session_key = delegate.session_key;
				this._expires = delegate.expires;
			
				prepareSigValues();
				onReady();
			}
			else
			{
				onConnectionError(delegate.errorMessage);
			}
		}
		
		/**
		 * Start a session for a Facebook widget application.
		 * You can choose not to pass in your secret if you plan on using a proxy server
		 * for your facebook calls.  If your api_key is set here and is also passed in via 
		 * flashvars then that that value will be ignored.
		 */
		public function startWidgetSession(flashVars:Object, api_key:String=null, secret:String=null):void
		{
			logger.debug("starting facebook widget session");
			
			sessionType = FacebookSessionType.WIDGET_APP;
			
			if(secret)
				this._secret = secret;
				
			if(api_key)
				this._api_key = api_key;
			
			//pull out all of the fb_sig values (which should be passed in as flashvars)
			//these properties will be used to verify communication
			this.fb_sig_values = new Object();
			
			logger.debug("- - - flashVars - - -");
			var prefix:String = "fb_sig";
			for(var prop:String in flashVars)
			{
				if(prop.substring(0,prefix.length) == prefix)
				{
					logger.debug(prop + ":" + flashVars[prop]);
					this.fb_sig_values[prop] = flashVars[prop]; 
				}
			}
			
			//save the information of those props into our class vars for use in the app
			this._user = getUser(parseInt(fb_sig_values['fb_sig_user']));
			this._user.isLoggedInUser = true;
			
			this._time = fb_sig_values['fb_sig_time'];
			
			this._expires = fb_sig_values['fb_sig_expires'];
			
			if(_user.uid != parseInt(fb_sig_values['fb_sig_profile']))
				this._currentProfile = getUser(parseInt(fb_sig_values['fb_sig_profile']));
			
			if(this._session_key == null)
				this._session_key = fb_sig_values['fb_sig_session_key'];
			
			logger.debug("session key: " + this._session_key);
			
			if(this._api_key == null)	
				this._api_key = fb_sig_values['fb_sig_api_key'];
			
			if(session_key)
				onReady();
			else
				onConnectionError("No session key for application session");
		}
		
		/**
		 * Helper function.  Called when the connection is ready.
		 */
		private function onReady():void
		{
			_isConnected = true;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Helper function.  Called when the connection fails to be made.
		 */
		private function onConnectionError(errorMessage:String):void
		{
			_isConnected = false;
			_connectionErrorMessage = errorMessage;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Take the properties we have and put them into the fb_sig_values object 
		 * in case we need to use them for a redirect server validation.
		 * This is a helper function to Desktop and Web app functions.
		 */
		private function prepareSigValues():void
		{
			var temp_sig_values:Object = new Object();

			temp_sig_values['user'] = this.user;
			temp_sig_values['time'] = this.time; 
			temp_sig_values['session_key'] = this.session_key;
			temp_sig_values['api_key'] = this.api_key;
			temp_sig_values['expires'] = this.expires;
			
			//calculate the sig for these values
			var a:Array = [];
			
			for( var p:String in temp_sig_values )
			{
				if( p !== 'sig' ){
					a.push( p + '=' + temp_sig_values[p] );
				}
			}
			
			a.sort();
			
			var s:String = '';
			
			for( var i:Number = 0; i < a.length; i++ )
			{
				s += a[i];
			}
			
			s += secret;
			var mySig:String = MD5.encrypt( s );
			
			//now put all these siggy things into our sig holder
			
			this.fb_sig_values = new Object()
			
			fb_sig_values['fb_sig'] = mySig;
			for(var j:String in temp_sig_values)
			{
				this.fb_sig_values['fb_sig_' + j] = temp_sig_values[j];
			}
		}

		// COLLECTION FUNCTIONS //////////
		
		/**
		 * This keeps a common collection of users so that all information gathered
		 * on users is stored here and updated.  Each user should have only one instance.
		 * 
		 * Creating a user should happen from this method.
		 */
		public function getUser(uid:int):FacebookUser
		{
			var user:FacebookUser = _userCollection.getItemById(uid) as FacebookUser;
			if(!user)
			{
				user = new FacebookUser(uid);
				_userCollection.addItem(user);
			}
			return user;
		}
		
		/**
		 * This keeps a common collection of groups so that all information gathered
		 * on groups is stored here and updated.  Each group should have only one instance.
		 * 
		 * Creating a group should happen from this method.
		 */
		public function getGroup(gid:Number):FacebookGroup
		{
			var group:FacebookGroup = _groupCollection.getItemById(gid) as FacebookGroup;
			if(!group)
			{
				group = new FacebookGroup(gid);
				_groupCollection.addItem(group);
			}
			return group;
		}
		
		/**
		 * This keeps a common collection of events so that all information gathered
		 * on events is stored here and updated.  Each event should have only one instance.
		 * 
		 * Creating an event should happen from this method.
		 */
		public function getEvent(eid:Number):FacebookEvent
		{
			var event:FacebookEvent = _eventCollection.getItemById(eid) as FacebookEvent;
			if(!event)
			{
				event = new FacebookEvent(eid);
				_eventCollection.addItem(event);
			}
			return event;
		}
	}
}