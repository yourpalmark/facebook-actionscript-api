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
  import fb.FBEvent;

  import flash.events.Event;
  import flash.events.EventDispatcher;

  import mx.controls.HTML;
  import mx.core.Application;

  public class RedirectTester extends EventDispatcher {
    private var origURL:String;
    private var nextURL:String;
    private var success:String;

    private var html:HTML = new HTML();
    
    public function RedirectTester(new_orig_url:String,
                                   new_next_url:String,
                                   new_success:String) {
      origURL = new_orig_url;
      nextURL = new_next_url;
      success = new_success;

      html.visible = html.includeInLayout = false;
      Application.application.addChild(html);
      html.addEventListener(Event.LOCATION_CHANGE, locationChange);
      html.location = origURL;
    }

    private function locationChange(event:Event):void {
      if (location == '' || location == origURL) return;
      if (location.indexOf(nextURL) == -1) return;
      if (location.indexOf(success) == -1)
        dispatchEvent(new FBEvent(FBEvent.FAILURE));
      else
        dispatchEvent(new FBEvent(FBEvent.SUCCESS));
      html.location = '';
    }
    
    public function get location():String { 
      return html.location;
    }
  }
}
