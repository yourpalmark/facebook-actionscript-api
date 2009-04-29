/*
  Copyright Facebook Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
 */
package fb {

  import com.adobe.serialization.json.JSON;
  
  import fb.display.FBAuthDialog;
  import fb.display.FBDialog;
  import fb.display.FBPermDialog;
  import fb.net.RedirectTester;
  
  import flash.events.EventDispatcher;
  import flash.net.SharedObject;

  public class FBConnect {
    // Enum constants
    public static const Connected:String = "Connected";
    public static const NotLoggedIn:String = "NotLoggedIn";

    // Path to check for logged in status
    private static const LoggedInPath:String = FBDialog.FacebookURL +
      "/extern/desktop_login_status.php";

    // Universal dispatcher of authorization changes
    public static var dispatcher:EventDispatcher = new EventDispatcher();

    // Publicly accessible globals about session states
    public static var api_key:String;
    [Bindable] public static var session:FBSession;

    // Permissions
    private static const allPermissions:Array = [
      'email',
      'offline_access',
      'status_update',
      'photo_upload',
      'create_listing',
      'create_event',
      'rsvp_event',
      'sms',
      'video_upload',
      'create_note',
      'share_item',
      'read_stream',
      'publish_stream',
      'auto_publish_short_feed'
    ];
    private static var permissions:Array = new Array();
    private static var validating_permissions:Array;

	protected static var authDialog:FBAuthDialog;
	protected static var permDialog:FBPermDialog;
	protected static var isShutdown:Boolean = false;

    // Local filestorage (desktop "cookie")
    private static var sharedObject:SharedObject;

    // Status getter/setter.  Setter triggers event.
    private static var _status:String = NotLoggedIn;
    public static function get status():String { return _status; }
    public static function set status(new_status:String):void {
      if (new_status != Connected &&
          new_status != NotLoggedIn) {
        return;
      }
      _status = new_status;

      dispatcher.dispatchEvent(new FBEvent(FBEvent.STATUS_CHANGED));
    }
    
    public static function shutdown():void {
    	isShutdown = true;
    	
    	if (authDialog && authDialog.closed == false) { authDialog.removeEventListener(FBEvent.CLOSED, loginDialogClosed); }
    	if (permDialog && permDialog.closed == false) { permDialog.removeEventListener(FBEvent.CLOSED, permissionsDialogClosed); }
    }
    // Must be called to start things off.
    public static function init(new_api_key:String):void {
      api_key = new_api_key;

      _status = NotLoggedIn;
      session = null;

      // If we have stored session data, let's pull it in
      sharedObject = SharedObject.getLocal(api_key);
      if (sharedObject.data["session_key"]) {
        session = new FBSession();
        session.key = sharedObject.data["session_key"];
        session.uid = sharedObject.data["uid"];
        session.expires = sharedObject.data["expires"];
        session.secret = sharedObject.data["secret"];
      }
    }

    /**********************************
     * EXTENDED PERMISSIONS
     **********************************/
    // Simply informs if we have had this permission granted
    public static function hasPermission(permission_name:String):Boolean {
      return (permissions.indexOf(permission_name) != -1);
    }
    
    //We have receaved a permissions error, so we can manually clear a permission, so connect can re-ask for it.
    public static function removePermission(permission_name:String):void {
    	var idx:int = permissions.indexOf(permission_name);
    	if (idx != -1) {
    		permissions.splice(idx, 1);
    	}
    }

    // Call this to require/validate a permission
    public static function requirePermissions(permission_names:Array):void {
      for each (var permission_name:String in permission_names) {
        if (allPermissions.indexOf(permission_name) == -1) return;
      }
      if (validating_permissions) return;

      // Ask about all these first, to see if we're already auth'd
      dispatcher.dispatchEvent(new FBEvent(FBEvent.ALERT,
                               {text:"Checking Extended Permissions"}));
      validating_permissions = permission_names;
      FBAPI.callMethod("fql.query", {
        query:"select " + permission_names.join(", ") +
          " from permissions where uid = " + FBConnect.session.uid
      }).addEventListener(FBEvent.SUCCESS, gotPermissionInfo);
    }

    // Callback from restserver of whether we have permission
    private static function gotPermissionInfo(event:FBEvent):void {
      var permissions_array:Array = event.data as Array;
      var permissions_granted:Object = permissions_array[0];

      // Update our cache of what we know about these permissions
      for (var permission_granted:String in permissions_granted) {
        if (permissions_granted[permission_granted] == 1 &&
            permissions.indexOf(permission_granted) == -1)
          permissions.push(permission_granted);
        else if (permissions_granted[permission_granted] == 0 &&
                 permissions.indexOf(permission_granted) != -1)
          permissions.splice(permissions.indexOf(permission_granted), 1);
      }

      // Check to see if we need more
      var permissions_needed:Array = new Array();
      for each (var validating_permission:String in validating_permissions)
        if (!hasPermission(validating_permission))
          permissions_needed.push(validating_permission);

      if (permissions_needed.length == 0) {
        validating_permissions = null;
        dispatcher.dispatchEvent(new FBEvent(FBEvent.PERMISSION_CHANGED));
      } else {
        dispatcher.dispatchEvent(new FBEvent(FBEvent.ALERT,
                                 {text:"Confirming Logged In Status"}));
        // Confirm we are logged in before trying the perm dialog
        var redirectTester:RedirectTester = new RedirectTester(
          LoggedInPath + "?next=" + FBDialog.NextPath + "&api_key=" + api_key,
          FBDialog.NextPath, 'result=logged_in');
        redirectTester.addEventListener(FBEvent.FAILURE,
          function(event:FBEvent):void {
            unauthenticated();
          });
        redirectTester.addEventListener(FBEvent.SUCCESS,
          function(event:FBEvent):void {
            confirmedLoggedIn(unescape(event.target.location),
                              permissions_needed);
          });
      }
    }

    // Callback when desktop_login_status has confirmed our login
    // We confirm our uid and proceed with PermDialog or we bail
    private static function confirmedLoggedIn(url:String,
                                              permissions_needed:Array):void {
      var uid_pattern:RegExp = /uid=(\d+)/;
      var uid:Number = Number(uid_pattern.exec(url)[1]);
      if (uid != session.uid) {
        unauthenticated();
      } else {
      	if (permDialog != null && permDialog.closed == false) {
      		//Remove Close listener here, since we don't need to know about it.
      		permDialog.removeEventListener(FBEvent.CLOSED, permissionsDialogClosed);
      		permDialog.close();
      	}
      	
      	//If we're shutting down, don't open a new window.
      	if (isShutdown) { return; }
      	
        permDialog = new FBPermDialog();
        permDialog.ext_perm = permissions_needed.join(",");
        permDialog.addEventListener(FBEvent.CLOSED, permissionsDialogClosed, false, 0, true);
        permDialog.show();
      }
    }

    // Callback when permissions dialog has closed
    private static function permissionsDialogClosed(event:FBEvent):void {
      // Loop thru and add all those permissions we've gotten
      if (event.data && event.data is Array) {
        var validated_permissions:Array = event.data as Array;
        for each (var validated_permission:String in validated_permissions) {
          permissions.push(validated_permission);
        }
      }
      validating_permissions = null;

      dispatcher.dispatchEvent(new FBEvent(FBEvent.PERMISSION_CHANGED));
    }

    /**********************************
     * AUTHORIZATION
     **********************************/
    // Our session key may have been deauthorized by the user
    // This method allows us to confirm it's still valid
    private static function validateSession():void {
      if (!api_key || !session) return;

      dispatcher.dispatchEvent(new FBEvent(FBEvent.ALERT,
                               {text:"Validating Session Key"}));
      var loggedIn:EventDispatcher =
        FBAPI.callMethod("users.getLoggedInUser");
      loggedIn.addEventListener(FBEvent.SUCCESS, gotLoggedInUser);
      loggedIn.addEventListener(FBEvent.FAILURE, noLoggedInUser);
    }

    // This will require we get a session key.
    // And validate if we already have one.
    public static function requireSession():void {
      if (!api_key) return;

      if (session) {
        validateSession();
      } else {
      	if (authDialog != null && authDialog.closed == false) {
      		authDialog.close();
  		}
  		
  		//If we're shutting down, don't open a new window.
  		if (isShutdown) { return; }
  		
        authDialog = new FBAuthDialog();
        authDialog.addEventListener(FBEvent.CLOSED, loginDialogClosed, false, 0, true);
        authDialog.show();
      }
    }
    
    // Callback from restserver if session key causes error
    private static function noLoggedInUser(event:FBEvent = null):void {
      session = null;
      SharedObject.getLocal(api_key).data["session_key"] = null;
      requireSession();
    }

    // Callback from restserver of whether session key is valid
    private static function gotLoggedInUser(event:FBEvent):void {
      var logged_in_user_id:Number = event.data as Number;
      if (logged_in_user_id == session.uid) status = Connected;
      else noLoggedInUser();
    }

    // Callback when authorization dialog has closed
    private static function loginDialogClosed(event:FBEvent):void {
      if (event.data) {
        var session_pattern:RegExp = /\{.+?\}/;
        var session_json:String = session_pattern.exec(
          unescape(authDialog.htmlWindow.location))[0];
        var session_obj:Object = JSON.decode(session_json);

        session = new FBSession();
        session.key = session_obj.session_key;
        session.secret = session_obj.secret;
        session.expires = session_obj.expires;
        session.uid = session_obj.uid;

        sharedObject.data["session_key"] = session.key;
        sharedObject.data["uid"] = session.uid;
        sharedObject.data["expires"] = session.expires;
        sharedObject.data["secret"] = session.secret;

        status = Connected;
      } else {
        status = NotLoggedIn;
      }
    }
    
    public static function logout():void {
		validating_permissions = null;
		session = null;
		SharedObject.getLocal(api_key).data["session_key"] = null;
		_status = NotLoggedIn;
    }

    // Called internally when we've discovered we're unauthenticated
    private static function unauthenticated():void {
      validating_permissions = null;
      session = null;
      SharedObject.getLocal(api_key).data["session_key"] = null;
      status = NotLoggedIn;
    }
  }
}
