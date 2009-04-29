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
package fb.net {
  import com.adobe.serialization.json.JSON;

  import fb.FBEvent;

  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;

  // Simple URLLoader extender will wrap the result from
  // it's own COMPLETE in a JSON.decode then dispatch a
  // FBEvent.SUCCESS with the JSON data.
  public class JSONLoader extends URLLoader {
    private var request:URLRequest;

    public function JSONLoader(new_request:URLRequest = null) {
      request = new_request;

      addEventListener(IOErrorEvent.IO_ERROR, reload);
      addEventListener(SecurityErrorEvent.SECURITY_ERROR, reload);
      addEventListener(Event.COMPLETE, success);
    }

    override public function load(new_request:URLRequest):void {
      if (new_request) request = new_request;
      super.load(new_request);
    }

    private function reload(event:Event = null):void {
      dispatchEvent(new FBEvent(FBEvent.RETRY));
      load(request);
    }

    private function success(event:Event):void {
      if (event.target.data.indexOf("<") != 0) {
        var eventData:* = JSON.decode(event.target.data);
        if (eventData.constructor == Object && eventData.error_code) {
          dispatchEvent(new FBEvent(FBEvent.FAILURE, eventData));
        }
        else
          dispatchEvent(new FBEvent(FBEvent.SUCCESS, eventData));
      } else {
        dispatchEvent(new FBEvent(FBEvent.FAILURE));
      }
    }
  }
}
