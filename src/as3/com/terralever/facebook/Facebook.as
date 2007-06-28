/*
Copyright (c) 2007 Terralever

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

package com.terralever.facebook
{
	import flash.events.Event;
	import mx.logging.Log;
	import flash.events.EventDispatcher;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import com.terralever.facebook.delegates.auth.*;
	import com.terralever.facebook.delegates.photos.*;
	import com.terralever.facebook.data.photos.*;
	import mx.core.Application;
	import com.gsolo.encryption.MD5;
	import mx.events.PropertyChangeEvent;
	
	[Bindable]
	public class Facebook extends EventDispatcher
	{	
		// VARIABLES //////////
		
		public var fb_sig_values:Object;
		private var _auth_token:String;
		
		// CONSTRUCTION //////////
		
		function Facebook():void
		{
			//nothing here
		}
		
		// GETTERS and SETTERS //////////
		
		/**
		 * The URL of the REST server that you will be using.
		 * This could either be the facebook server (default) (for desktop applications) 
		 * or your own server (for redirection/secret insertion)
		 */
		private var _default_rest_url:String = "http://api.facebook.com/restserver.php";
		public function get default_rest_url():String { return _default_rest_url; }
		public function set default_rest_url(newVal:String):void { this._default_rest_url = newVal; }
		 
		private var _rest_url:String;
		public function set rest_url(newVal:String):void { _rest_url = newVal; }
		public function get rest_url():String {
			if(_rest_url == null)
				return default_rest_url;
			else
				return _rest_url; 
		}
		
		/**
		 * The URL of the login page a user will be directed to (for desktop applications)
		 * The default will work fine but you can set it to something else.
		 */
		private var _login_url:String = "http://www.facebook.com/login.php";
		public function get login_url():String { return _login_url; }
		public function set login_url(newVal:String):void { this._login_url = newVal; }
		
		/**
		 * The "api_key" associated with your application and provided by Facebook.
		 */
		private var _api_key:String; 
		public function get api_key():String { return _api_key;	}
		
		/**
		 * The "secret" associated with your application and provided by Facebook.
		 * You should ONLY use this for desktop applications!
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
		public function get session_key():String { return _session_key; }
		
		/** 
		 * user id
		 */
		private var _user:String;
		public function get user():String { return _user; }
		
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
		 * The guid of the user whos page is being viewed.
		 * If no profile property is set, the logged in user's guid is returned
		 */
		private var _profile:String;
		public function get profile():String
		{
			if(_profile == null)
				return user;
			else
				return _profile;
		}
		
		/**
		 * The context the application is currently in.  
		 * The options are "narrow", "wide", and "application".
		 * It defaults to "application"
		 * The values are housed in FacebookContextType
		 */
		private var _context:String = FacebookContextType.APPLICATION;
		public function get context():String { return _context; }
		public function set context(newVal:String):void { /*for binding*/ }
		
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
		 * Returns true if you are viewing our own profile
		 */ 
		public function get isUsersProfile():Boolean 
		{ 
			return this.profile == this.user; 
		}
		
		/**
		 * Returns true when the connection has been established and we are ready to make calls
		 */
		private var _isConnected:Boolean = false;
		public function get isConnected():Boolean { return this._isConnected; }
		public function set isConnected(newVal:Boolean):void { /*for binding*/ } 
		
		// PUBLIC FUNCTIONS //////////
		
		// SESSION FUNCTIONS //////////

		/**
		 * Start a session for a web-based application
		 */
		public function startWebSession():void
		{
			sessionType = FacebookSessionType.WEB_APP;
			//pull the auth_token (which should have been sent in as a flashvar)
			_auth_token = Application.application.parameters["auth_token"];
			
			//validate the session
			var delegate:GetSession_delegate = new GetSession_delegate(this, _auth_token);
			delegate.addEventListener(Event.COMPLETE, startWebSessionReply);
		}
		
		/**
		 * Start a session for a desktop based application.
		 * For this you need to know and pass the application api_key and secret.
		 * The user will be prompted to login to their Facebook page after which you should call
		 * 
		 */
		public function startDesktopSession(api_key:String, secret:String):void
		{
			this._api_key = api_key;
			this._secret = secret;
			
			sessionType = FacebookSessionType.DESKTOP_APP;
			//first we need to construct a token
			var delegate:CreateToken_delegate = new CreateToken_delegate(this);
			delegate.addEventListener(Event.COMPLETE, onDesktopTokenCreated);
		}
		
		/**
		 * Once a token has been created and a user has logged in we must manually validate this session
		 * with a call to this method.  Once this has been sucessfully called, the Facebook session is ready
		 */
		public function validateDesktopSession():void
		{
			//validate the session
			var delegate:GetSession_delegate = new GetSession_delegate(this, _auth_token);
			delegate.addEventListener(Event.COMPLETE, validateDesktopSessionReply);
		}
		
		/**
		 * Start a session for a Facebook widget application
		 */
		public function startWidgetSession(secret:String=null):void
		{
			sessionType = FacebookSessionType.WIDGET_APP;
			
			if(secret)
			{
				Log.getLogger("terralever.facebook").warn("API & SECRET SHOULD NOT BE USED IN WIDGET MODE!  THIS SHOULD BE USED FOR TESTING ONLY!");
				this._secret = secret;
			}
			
			//pull out all of the fb_sig values (which should be passed in as flashvars)
			//these properties will be used to verify communication
			this.fb_sig_values = new Object;
			
			var prefix:String = "fb_sig";
			for(var prop:String in Application.application.parameters)
			{
				if(prop.substring(0,prefix.length) == prefix)
				{
					this.fb_sig_values[prop] = Application.application.parameters[prop]; 
				}
			}
			
			//save the widget context
			var newContext:String = Application.application.parameters['context'];
			if(FacebookContextType.check(newContext))
				this._context = newContext;
			
			//save the information of those props into our class vars for use in the app
			this._user = fb_sig_values['fb_sig_user'];
			this._time = fb_sig_values['fb_sig_time'];
			this._expires = fb_sig_values['fb_sig_expires'];
			this._profile = fb_sig_values['fb_sig_profile'];
			//this._session_key = fb_sig_values['fb_sig_session_key'];
			//this._api_key = fb_sig_values['fb_sig_api_key'];
			
			onReady();
		}
		
		// SERVICE FUNCTIONS //////////
		
		/*
			All of these service functions use a delegate to do the communication and response parsing.
			The delegate is returned (so that event listeners can be established, etc) however you can
			pass in an (optional) callback function for ease of use.
		*/
		
		// facebook.photos
		
		/**
		 * Adds a tag with the given information to a photo.
		 */
		public function photos_addTag(pid:int, tag_uid:int, tag_text:String, x:Number, y:Number, callback:Function):GetTags_delegate
		{
			return photos_addTags([{pid:int, tag_uid:tag_uid, tag_text:tag_text, x:x, y:y}], callback);
		}
		
		/**
		 * Add multiple tags.  Each item in the array must have:
		 * pid, tag_uid OR tag_text, x, y
		 */
		public function photos_addTags(tags:Array, callback:Function = null):GetTags_delegate
		{
			var delegate:GetTags_delegate = new GetTags_delegate(this, tags);
			
			if(callback != null)
				delegate.addEventListener(Event.COMPLETE, callback);
				
			return delegate;
		}
		
		public function photos_getAlbums(uid:String, callback:Function = null, getCoverPhotos:Boolean = false):GetAlbums_delegate
		{
			var delegate:GetAlbums_delegate = new GetAlbums_delegate(this, uid, getCoverPhotos);
			
			if(callback != null)
				delegate.addEventListener(Event.COMPLETE, callback);
				
			return delegate;
		}
		
		public function photos_get(subj_id:Object, aid:Object, pids:Array, callback:Function = null):GetPhotos_delegate
		{
			var delegate:GetPhotos_delegate = new GetPhotos_delegate(this, subj_id, aid, pids);
			
			if(callback != null)
				delegate.addEventListener(Event.COMPLETE, callback);
				
			return delegate;
		}
		
		// HELPER FUNCTIONS //////////

		public function getPhotosForAlbum(album:FacebookAlbum, callback:Function = null):GetPhotos_delegate
		{
			return photos_get(null, album.aid, null, callback);
		}
		
		// PRIVATE FUNCTIONS //////////
		
		private function startWebSessionReply(event:Event):void
		{
			var delegate:GetSession_delegate = event.target as GetSession_delegate;
			
			this._user = delegate.uid;
			this._secret = delegate.secret;
			this._session_key = delegate.session_key;
			this._expires = delegate.expires;
			
			prepareSigValues();
			onReady();
		}
		
		private function onDesktopTokenCreated(event:Event):void
		{
			var delegate:CreateToken_delegate = event.target as CreateToken_delegate;
			_auth_token = delegate.auth_token;
			
			Log.getLogger("terralever.facebook").debug("token created: " + _auth_token);

			//now that we have an auth_token we need the user to login with it
			var authenticateLoginURL:String = login_url + "?api_key="+api_key+"&v=1.0&auth_token="+_auth_token;
			Log.getLogger("terralever.facebook").debug("prompting user for login at: " + authenticateLoginURL);
			navigateToURL(new URLRequest(authenticateLoginURL), "_blank");
		}

		private function validateDesktopSessionReply(event:Event):void
		{
			var delegate:GetSession_delegate = event.target as GetSession_delegate;
			
			this._user = delegate.uid;
			this._session_key = delegate.session_key;
			this._expires = delegate.expires;
			
			prepareSigValues();
			onReady();
		}
		
		/**
		 * Helper function.  Called with the connection is ready.
		 */
		private function onReady():void
		{
			_isConnected = true;
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isConnected", false, true));
			dispatchEvent(new Event("ready"));
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
	}
}