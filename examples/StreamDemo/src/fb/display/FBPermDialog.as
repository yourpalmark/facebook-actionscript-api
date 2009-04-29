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
// FBDialog extension specifically for authorize
// Please see FBDialog for more details.
package fb.display {

  import fb.display.FBDialog;

  import flash.events.Event;

  public class FBPermDialog extends FBDialog {
    public function FBPermDialog() {
      title = "Facebook Connect Extended Permissions";
      location = "/connect/prompt_permissions.php";
      extraParams["next"] = NextPath + "?xxRESULTTOKENxx";
      extraParams["extern"] = 1;
      extraParams["channel_url"] = NextPath;
    }

    public function get ext_perm():String { return extraParams["ext_perm"]; }
    public function set ext_perm(new_ext_perm:String):void {
      extraParams["ext_perm"] = new_ext_perm;
    }

    override protected function htmlLocationChange(event:Event):void {
      super.htmlLocationChange(event);

      if (!htmlWindow || htmlWindow.location == '' ||
        htmlWindow.location == location || closed) return;

      // We check and pull out the string of those that were authorized
      if (htmlWindow.location.indexOf(NextPath) == 0) {
        var unescaped_location:String = unescape(htmlWindow.location);
        var results:String =
          unescaped_location.substring(unescaped_location.indexOf("?") + 1);
        hide(results.split(","));
      }
      // If this is not our base url then we're off track somehow
      else if (htmlWindow.location.indexOf(location) == -1)
        hide(false);
      else transition();
    }
  }
}
