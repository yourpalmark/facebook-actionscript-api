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
  import com.adobe.crypto.MD5;
  import com.adobe.serialization.json.JSON;

  import fb.FBConnect;
  import fb.FBEvent;
  import fb.net.FBPost;
  import fb.net.JSONLoader;

  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.filesystem.File;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.net.URLRequestMethod;
  import flash.net.URLVariables;

  import mx.controls.HTML;

  public class FBAPI {
    private static const restURL:String =
      "http://api.facebook.com/restserver.php";

    private static var auth_token:String;
    private static var session_key:String;
    private static var uid:String;
    private static var expires:String;

    private static var htmlWindow:HTML = new HTML();

    private static var datePrefix:String = (new Date()).time.toString();
    private static var callCount:int = 0;

    // Simple way of accessing our restserver.php
    //   method:  Method to call (like friends.get)
    //   args:  Key=>Value set of args to include.
    //   Note that v, format, api_key, call_id, and session_key
    //     are all auto-included for you.
    //   So for many api calls you don't need any args at all.
    // The method returns an EventDispatcher that will then
    //   dispatch an FBEvent.SUCCESS upon return from the server
    //   with .data being the json-decoded results.
    // For example to call friends.get:
    // FBAPI.callMethod("friends.get").addEventListener(FBEvent.SUCCESS,
    //   function(event:FBEvent):void {
    //     trace("All friend ids are: " + event.data.join(","))
    //   });
    // Or if I wanted to tag photo 4145 with user 1681, and I didn't
    //   care to check the result (since it's just "1"):
    // FBAPI.callMethod("photos.addTag", {pid:4145, tag_uid:1681, x:40, y:20});
    public static function callMethod(method:String,
      callArgs:Object = null):JSONLoader {
      if (!FBConnect.api_key || !FBConnect.session)
        return null;

      var urlArgs:URLVariables = flattenArgs(method, callArgs);

      var loader:JSONLoader = new JSONLoader();

      var request:URLRequest = new URLRequest(restURL);
      request.contentType = "application/x-www-form-urlencoded";
      request.method = URLRequestMethod.GET;
      request.data = urlArgs;
      loader.dataFormat = URLLoaderDataFormat.TEXT;
      loader.load(request);

      return loader;
    }

    // This will upload a photo for you.
    // Demonstration of its use is coming soon.
    public static function uploadPhoto(photo:File,
      callArgs:Object = null):JSONLoader {
      if (!FBConnect.api_key || !FBConnect.session)
        return null;

      var urlArgs:URLVariables = flattenArgs("photos.upload", callArgs);
      var post:FBPost= new FBPost();
      for (var urlArg:String in urlArgs)
        post.writePostData(urlArg, urlArgs[urlArg]);
      post.writeFileData(photo);
      post.close();

      var loader:JSONLoader = new JSONLoader();

      var request:URLRequest = new URLRequest(restURL);
      request.method = URLRequestMethod.POST;
      request.contentType = "multipart/form-data; boundary="+FBPost.boundary;
      request.data = post.data;
      loader.dataFormat = URLLoaderDataFormat.BINARY;
      loader.load(request);

      return loader;
    }

    // Utility function takes the method and callArgs
    // And builds a URLVariables with them and
    //   all the other default cruft required.
    private static function flattenArgs(method:String,
      callArgs:Object = null):URLVariables {
      callCount++;

      var urlArgs:URLVariables = new URLVariables();
      if (callArgs) {
        for (var key:String in callArgs) {
          if (callArgs[key] is Array) {
            urlArgs[key] = callArgs[key].join(",");
          } else {
            urlArgs[key] = callArgs[key];
          }
        }
      }

      urlArgs['v'] = '1.0';
      urlArgs['format'] = 'JSON';
      urlArgs['method'] = method;
      urlArgs['api_key'] = FBConnect.api_key;
      urlArgs['call_id'] = datePrefix + callCount;
      urlArgs['session_key'] = FBConnect.session.key;

      var argsArray:Array = new Array();
      for(var arg:String in urlArgs) {
        var val:* = urlArgs[arg];
        argsArray.push(arg + "=" + val);
      }
      argsArray.sort();
      var hashString:String = argsArray.join("") + FBConnect.session.secret;
      urlArgs['sig'] = MD5.hash(hashString);

      return urlArgs;
    }
  }
}
