/*
  Copyright (c) 2010, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

  * Neither the name of Adobe Systems Incorporated nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package com.facebook.graph {

  import com.adobe.serialization.json.JSON;
  import com.adobe.serialization.json.JSONParseError;
  import com.facebook.graph.core.AbstractFacebook;
  import com.facebook.graph.core.FacebookJSBridge;
  import com.facebook.graph.core.FacebookURLDefaults;
  import com.facebook.graph.data.FQLMultiQuery;
  import com.facebook.graph.data.FacebookSession;
  import com.facebook.graph.net.FacebookRequest;
  import com.facebook.graph.utils.IResultParser;
  
  import flash.external.ExternalInterface;
  import flash.net.URLRequest;
  import flash.net.URLRequestMethod;
  import flash.net.URLVariables;
  import flash.net.navigateToURL;
  import flash.utils.Dictionary;

  /**
   * Main class to connect to Facebook Graph API services.
   * For use on the web or mobile to call Facebook API methods.
   *
   * This class abstracts the Facebook Javascript SDK
   * to handle authentication showing sharing windows and
   * maintaining the current session.
   *
   */
  public class Facebook extends AbstractFacebook {

    /**
     * @private
     *
     */
    protected var jsCallbacks:Object;
	
	/**
	 * @private
	 *
	 */
	protected var openUICalls:Dictionary;
	
	/**
	 * @private
	 *
	 */
	protected var jsBridge:FacebookJSBridge;

    /**
     * @private
     *
     */
    protected var applicationId:String;

    /**
     * @private
     *
     */
    protected static var _instance:Facebook;

    /**
     * @private
     *
     */
    protected static var _canInit:Boolean = false;

    /**
     * @private
     *
     */
    protected var _initCallback:Function;

    /**
     * @private
     *
     */
    protected var _loginCallback:Function;

    /**
     * @private
     *
     */
    protected var _logoutCallback:Function;

    /**
     * Creates an instance of Facebook.
     *
     */
    public function Facebook() {
      super();

      if (_canInit == false) {
        throw new Error(
          'Facebook is an singleton and cannot be instantiated.'
        );
      }
	  
	  jsBridge = new FacebookJSBridge(); //create an instance

      jsCallbacks = {};
	  
	  openUICalls = new Dictionary();
    }

    //Public API
    /**
     * Initializes this Facebook singleton with your Application ID.
     * You must call this method first.
     *
     * @param applicationId The application ID you created at
     * http://www.facebook.com/developers/apps.php
     *
     * @param callback (Optional)
	 * Method to call when initialization is complete.
     * The handler must have the signature of callback(success:Object, fail:Object);
     * Success will be a FacebookSession if successful, or null if not.
     *
     * @param options (Optional)
     * Object of options used to instantiate the underling Javascript SDK
	 * 
	 * @param accessToken (Optional)
     * A valid Facebook access token. If you have a previously saved access token, you can pass it in here.
     *
     * @see http://developers.facebook.com/docs/reference/javascript/FB.init
     *
     */
    public static function init(applicationId:String,
                  callback:Function = null,
                  options:Object = null,
				  accessToken:String = null
    ):void {

      getInstance().init(applicationId, callback, options, accessToken);
    }
	
	public static function set locale(value:String):void {
		getInstance().locale = value;
	}

    /**
     * Shows the Facebook login window to the end user.
     *
     * @param callback The method to call when login is successful.
     * The handler must have the signature of callback(success:Object, fail:Object);
     * Success will be a FacebookSession if successful, or null if not.
     *
     * @param options Values to modify the behavior of the login window.
     * http://developers.facebook.com/docs/reference/javascript/FB.login
     *
     */
    public static function login(callback:Function, options:Object = null):void {
      getInstance().login(callback, options);
    }

    /**
     * Re-directs the user to a mobile-friendly login form.
     *
     * @param redirectUri After a successful login,
     * Facebook will redirect the user back to this URL,
     * where the underlying Javascript SDK will notify this swf
     * that a valid login has occurred.
     *
     * @param display Type of login form to show to the user.
     * <ul>
     *	<li>touch Default; (Recommended)
     * 		Smartphone, full featured web browsers.
     * 	</li>
     *
     *	<li>wap;
     *		Older mobile web browsers,
     * 		shows a slimmer UI to the end user.
     * 	</li>
     * </ul>
	 * 
	 * @param extendedPermissions (Optional) Array of extended permissions
     * to ask the user for once they are logged in.
     *
     * @see http://developers.facebook.com/docs/guides/mobile/
     *
     */
    public static function mobileLogin(redirectUri:String,
                       display:String = 'touch',
					   extendedPermissions:Array = null
    ):void {

      var data:URLVariables = new URLVariables();
      data.client_id = getInstance().applicationId;
      data.redirect_uri = redirectUri;
      data.display = display;	  
	  if (extendedPermissions != null) { data.scope = extendedPermissions.join(","); }

      var req:URLRequest = new URLRequest(FacebookURLDefaults.AUTH_URL);
      req.method = URLRequestMethod.GET;
      req.data = data;

      navigateToURL(req, '_self');
    }
	
	/**
	 * Logs the user out after being logged in with mobileLogin().
	 *
	 * @param redirectUri After logout, Facebook will redirect
	 * the user back to this URL.
	 *
	 */
	public static function mobileLogout(redirectUri:String):void {
		getInstance().session = null;
		
		var data:URLVariables = new URLVariables();
		data.confirm = 1;
		data.next = redirectUri;	
		
		var req:URLRequest = new URLRequest("http://m.facebook.com/logout.php");
		req.method = URLRequestMethod.GET;
		req.data = data;
		
		navigateToURL(req, '_self');				
	}

    /**
     * Logs the user out of their current session.
     *
     * @param callback Method to call when logout is complete.
     *
     */
    public static function logout(callback:Function):void {
      getInstance().logout(callback);
    }

    /**
     * Shows a Facebook sharing dialog.
     *
     * @param method The related method for this dialog
     *	(ex. stream.publish).
     * @param data Data to pass to the dialog, date will be JSON encoded.
	 * @param callback (Optional) Method to call when complete
     * @param display (Optional) The type of dialog to show (iframe or popup).
     * @see http://developers.facebook.com/docs/reference/javascript/FB.ui
     *
     */
    public static function ui(method:String,
                    data:Object,
					callback:Function=null,
                    display:String=null
       ):void {

      getInstance().ui(method, data, callback, display);
    }

    /**
     * Makes a new request on the Facebook Graph API.
     *
     * @param method The method to call on the Graph API.
     * For example, to load the user's current friends, pass: /me/friends
     *
     * @param calllback Method that will be called when this request is complete
     * The handler must have the signature of callback(result:Object, fail:Object);
     * On success, result will be the object data returned from Facebook.
     * On fail, result will be null and fail will contain information about the error.
     *
     * @param params Any parameters to pass to Facebook.
     * For example, you can pass {file:myPhoto, message:'Some message'};
     * this will upload a photo to Facebook.
     * @param requestMethod
     * The URLRequestMethod used to send values to Facebook.
     * The graph API follows correct Request method conventions.
     * GET will return data from Facebook.
     * POST will send data to Facebook.
     * DELETE will delete an object from Facebook.
     *
     * @see flash.net.URLRequestMethod
     * @see http://developers.facebook.com/docs/api
     *
     */
    public static function api(method:String,
                     callback:Function = null,
                     params:* = null,
                     requestMethod:String = 'GET'
    ):void {

      return getInstance().api(method,
        callback,
        params,
        requestMethod
      );
    }
	
	/**
     * Returns a reference to the entire raw object
	 * Facebook returns (including paging, etc.).
     *
     * @param data The result object.
     *
     * @see http://developers.facebook.com/docs/api#reading
     *
     */
	public static function getRawResult(data:Object):Object {			
		return getInstance().getRawResult(data);
	}
	
	/**
     * Asks if another page exists
	 * after this result object.
     *
     * @param data The result object.
     *
     * @see http://developers.facebook.com/docs/api#reading
     *
     */
	public static function hasNext(data:Object):Boolean {
		var result:Object = getInstance().getRawResult(data);
		if(!result.paging){ return false; }
		return (result.paging.next != null);
	}
	
	/**
     * Asks if a page exists
	 * before this result object.
     *
     * @param data The result object.
     *
     * @see http://developers.facebook.com/docs/api#reading
     *
     */
	public static function hasPrevious(data:Object):Boolean {
		var result:Object = getInstance().getRawResult(data);
		if(!result.paging){ return false; }
		return (result.paging.previous != null);
	}
	
	/**
     * Retrieves the next page that is associated with result object passed in.
     *
     * @param data The result object.
	 * @param callback Method that will be called when this request is complete
     * The handler must have the signature of callback(result:Object, fail:Object);
     * On success, result will be the object data returned from Facebook.
     * On fail, result will be null and fail will contain information about the error.
	 * 
	 * @see com.facebook.graph.net.FacebookDesktop#request()
     * @see http://developers.facebook.com/docs/api#reading
     *
     */
	public static function nextPage(data:Object, callback:Function):void {
		getInstance().nextPage(data, callback);
	}
	
	/**
     * Retrieves the previous page that is associated with result object passed in.
     *
     * @param data The result object.
	 * @param callback Method that will be called when this request is complete
     * The handler must have the signature of callback(result:Object, fail:Object);
     * On success, result will be the object data returned from Facebook.
     * On fail, result will be null and fail will contain information about the error.
     *
	 * @see com.facebook.graph.net.FacebookDesktop#request()
     * @see http://developers.facebook.com/docs/api#reading
     *
     */
	public static function previousPage(data:Object, callback:Function):void {
		getInstance().previousPage(data, callback);
	}

    /**
     * Shortcut method to post data to Facebook.
     * Alternatively,
     * you can call Facebook.request and use POST for requestMethod.
     *
     * @see com.facebook.graph.net.Facebook#api()
     */
    public static function postData(
      method:String,
      callback:Function = null,
      params:Object = null
    ):void {

      api(method, callback, params, URLRequestMethod.POST);
    }
	
	/**
	 * Executes an FQL query on api.facebook.com.
	 * 
	 * @param query The FQL query string to execute.
	 * @param values Replaces string values in the in the query. 
	 * ie. Replaces {digit} or {id} with the corresponding key-value in the values object 
	 * @see http://developers.facebook.com/docs/reference/fql/
     * @see com.facebook.graph.net.Facebook#callRestAPI()
	 * 
	 */	
	public static function fqlQuery(query:String, callback:Function=null, values:Object=null):void {
		getInstance().fqlQuery(query, callback, values);
	}
	
	/**
	 * Executes an FQL multiquery on api.facebook.com.
	 * 
	 * @param queries FQLMultiQuery The FQL queries to execute.
	 * @param parser IResultParser The parser used to parse result into object of name/value pairs. 
	 * @see http://developers.facebook.com/docs/reference/fql/
	 * @see com.facebook.graph.net.Facebook#callRestAPI()
	 * 
	 */	
	public static function fqlMultiQuery(queries:FQLMultiQuery, callback:Function=null, parser:IResultParser=null):void {
		getInstance().fqlMultiQuery(queries, callback, parser);
	}

    /**
     * Used to make old style RESTful API calls on Facebook.
     * Normally, you would use the Graph API to request data.
     * This method is here in case you need to use an old method,
     * such as FQL.
     *
     * @param methodName Name of the method to call on api.facebook.com
     * (ex, fql.query).
     * @param values Any values to pass to this request.
     * @param requestMethod URLRequestMethod used to send data to Facebook.
     *
     */
    public static function callRestAPI(methodName:String,
                       callback:Function,
                       values:* = null,
                       requestMethod:String = 'GET'
    ):void {

      return getInstance().callRestAPI(methodName, callback, values, requestMethod);
    }

    /**
     * Utility method to format a picture URL,
     * in order to load an image from Facebook.
     *
     * @param id The ID you wish to load an image from.
     * @param type The size of image to display from Facebook
     * (square, small, or large).
     *
     * @see http://developers.facebook.com/docs/api#pictures
     *
     */
    public static function getImageUrl(id:String,
                       type:String = null
    ):String {

      return getInstance().getImageUrl(id, type);
    }

    /**
     * Deletes an object from Facebook.
     * The current user must have granted extended permission
     * to delete the corresponding object,
     * or an error will be returned.
     *
     * @param method The ID and connection of the object to delete.
     * For example, /POST_ID/like to remove a like from a message.
     *
     * @see http://developers.facebook.com/docs/api#deleting
     * @see com.facebook.graph.net.FacebookDesktop#api()
     *
     */
    public static function deleteObject(method:String, callback:Function = null):void {
      getInstance().deleteObject(method, callback);
    }

    /**
     * Utility method to add listeners to the underlying Facebook library.
     * @param event Name of the Javascript event to listen for.
     * @param listener Name of function to call when event is fired.
     *
     * This method will need to accept an optional result:Object,
     * that will be the decoded JSON result, if one exists.
     *
     * @see http://developers.facebook.com/docs/reference/javascript/FB.Event.subscribe
     *
     */
    public static function addJSEventListener(event:String,
                          listener:Function
    ):void {

      getInstance().addJSEventListener(event, listener);
    }

    /**
     * Removes a Javascript event listener,
     * added by Facebook.addJSEventListener();
     *
     * @see #addJSEventListener();
     *
     */
    public static function removeJSEventListener(event:String,
                           listener:Function
    ):void {

      getInstance().removeJSEventListener(event, listener);
    }

    /**
     * Checks to see if a specified event listener exists.
     *
     */
    public static function hasJSEventListener(event:String,
                          listener:Function
    ):Boolean {

      return getInstance().hasJSEventListener(event, listener);
    }

    /**
     * @see http://developers.facebook.com/docs/reference/javascript/FB.Canvas.setAutoResize
     *
     */
    public static function setCanvasAutoResize(autoSize:Boolean = true,
                           interval:uint = 100
    ):void {

      getInstance().setCanvasAutoResize(autoSize, interval);
    }

    /**
     * @see http://developers.facebook.com/docs/reference/javascript/FB.Canvas.setSize
     *
     */
    public static function setCanvasSize(width:Number, height:Number):void {
      getInstance().setCanvasSize(width, height);
    }

    /**
     * Calls an arbitrary Javascript method on the underlying HTML page.
     *
     */
    public static function callJS(methodName:String, params:Object):void {
      getInstance().callJS(methodName, params);
    }

    /**
     * Synchronous method to retrieve the current user's session.
     *
     */
    public static function getSession():FacebookSession {
      return getInstance().getSession();
    }

    /**
    * Asynchronous method to get the user's current session from Facebook.
    *
    * This method calls out to the underlying Javascript SDK
    * to check what the current user's login status is.
    * You can listen for a javscript event by using
    * Facebook.addJSEventListener('auth.sessionChange', callback)
    * @see http://developers.facebook.com/docs/reference/javascript/FB.getLoginStatus
    *
    */
    public static function getLoginStatus():void {
      getInstance().getLoginStatus();
    }

    //Protected methods
    /**
     * @private
     *
     */
    protected function init(applicationId:String,
              callback:Function = null,
              options:Object = null,
			  accessToken:String = null
    ):void {
		
      ExternalInterface.addCallback('handleJsEvent', handleJSEvent);
      ExternalInterface.addCallback('sessionChange', handleSessionChange);
	  ExternalInterface.addCallback('logout', handleLogout);
	  ExternalInterface.addCallback('uiResponse', handleUI);

      _initCallback = callback;
	  
      this.applicationId = applicationId;

      if (options == null) { options = {};}
      options.appId = applicationId;
	  
      ExternalInterface.call('FBAS.init', JSON.encode(options));
	  
	  if (accessToken != null) {		  
		  session = new FacebookSession();
		  session.accessToken = accessToken;		  
	  }

      getLoginStatus();
	  
    }

    /**
     * @private
     *
     */
    protected function getLoginStatus():void {
      ExternalInterface.call('FBAS.getLoginStatus');
    }

    /**
     * @private
     *
     */
    protected function callJS(methodName:String, params:Object):void {
      ExternalInterface.call(methodName, params);
    }

    /**
     * @private
     *
     */
    protected function setCanvasSize(width:Number, height:Number):void {
      ExternalInterface.call('FBAS.setCanvasSize', width, height);
    }

    /**
     * @private
     *
     */
    protected function setCanvasAutoResize(autoSize:Boolean = true,
                         interval:uint = 100
    ):void {

      ExternalInterface.call('FBAS.setCanvasAutoResize',
        autoSize,
        interval
      );
    }

    /**
     * @private
     *
     */
    protected function login(callback:Function, options:Object = null):void {
      _loginCallback = callback;

      ExternalInterface.call('FBAS.login', JSON.encode(options));
    }

    /**
     * @private
     *
     */
    protected function logout(callback:Function):void {
      _logoutCallback = callback;      
      ExternalInterface.call('FBAS.logout');
    }

    /**
     * @private
     *
     */
    protected function getSession():FacebookSession {
      var result:String = ExternalInterface.call('FBAS.getSession');
      var sessionObj:Object;

      try {
        sessionObj = JSON.decode(result);
      } catch (e:*) {
        return null;
      }

      var s:FacebookSession = new FacebookSession();
      s.fromJSON(sessionObj);
      this.session = s;

      return session;
    }

    /**
     * @private
     *
     */
    protected function ui(method:String,
                  data:Object,
				  callback:Function=null,
                  display:String=null
    ):void {

      data.method = method;

	  if (callback != null) {
		  openUICalls[method] = callback;
	  }
	  
      if (display) {
        data.display = display;
      }

      ExternalInterface.call('FBAS.ui', JSON.encode(data));
    }

    /**
     * @private
     *
     */
    protected function addJSEventListener(event:String,
                        listener:Function
    ):void {

      if (jsCallbacks[event] == null) {
        jsCallbacks[event] = new Dictionary();
        ExternalInterface.call('FBAS.addEventListener', event);
      }

      jsCallbacks[event][listener] = null;
    }

    /**
     * @private
     *
     */
    protected function removeJSEventListener(event:String,
                         listener:Function
    ):void {

      if (jsCallbacks[event] == null) { return; }

      delete jsCallbacks[event][listener];
    }

    /**
     * @private
     *
     */
    protected function hasJSEventListener(event:String,
                        listener:Function
    ):Boolean {

      if (jsCallbacks[event] == null
        || jsCallbacks[event][listener] !== null
      ) {
        return false;
      }

      return true;
    }
	
	/**
	 * @private
	 *
	 */
	protected function handleUI( result:String, method:String ):void {
		var decodedResult:Object = result ? JSON.decode(result) : null;
		var uiCallback:Function = openUICalls[method];
		if (uiCallback === null) {
			delete openUICalls[method];
		} else {
			uiCallback(decodedResult);
			delete openUICalls[method];
		}
	}

    /**
     * @private
     *
     */
    protected function handleLogout():void {
	  session = null;
      if (_logoutCallback != null) {
        _logoutCallback(true);
        _logoutCallback = null;
      }
    }

    /**
     * @private
     *
     */
    protected function handleJSEvent(event:String,
                     result:String = null
    ):void {

      if (jsCallbacks[event] != null) {
        var decodedResult:Object;
        try {
          decodedResult = JSON.decode(result);
        } catch (e:JSONParseError) { }

        for (var func:Object in jsCallbacks[event]) {
          (func as Function)(decodedResult);
          delete jsCallbacks[event][func];
        }
      }
    }

    /**
     * @private
     *
     */
    protected function handleSessionChange(result:String,
                         permissions:String = null
    ):void {
      var resultObj:Object;
      var success:Boolean = true;

      if (result != null) {
        try {
          resultObj = JSON.decode(result);
        } catch (e:JSONParseError) {
          success = false;
        }
      } else {
        success = false;
      }

      if (success) {
        if (session == null) {
          session = new FacebookSession();		  
          session.fromJSON(resultObj);
        } else {
          session.fromJSON(resultObj);
        }

        if (permissions != null) {
          try {
            session.availablePermissions = JSON.decode(permissions);
          } catch (e:JSONParseError) {
            session.availablePermissions = null;
          }
        }
      }

      if (_initCallback != null) {
        _initCallback(session, null);
        _initCallback = null;
      }

      if (_loginCallback != null) {
        _loginCallback(session, null);
        _loginCallback = null;
      }
    }

    /**
     * @private
     *
     */
    protected static function getInstance():Facebook {
      if (_instance == null) {
        _canInit = true;
        _instance = new Facebook();
        _canInit = false;
      }
      return _instance;
    }
  }
}
