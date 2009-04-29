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
// FBDialog extension specifically for login and tos
// Please see FBDialog for more details.
package fb.display {
	
  import fb.display.FBDialog;
  import flash.events.Event;

 
  public class FBAuthDialog extends FBDialog {
    private static const FailurePath:String = FBDialog.FacebookURL +
      "/connect/login_failure.html";

    public function FBAuthDialog() {
      title = "Facebook Connect Authorization";
      location = "/login.php";
      extraParams["next"] = NextPath;
      extraParams["return_session"] = true;
      extraParams["cancel_url"] = FailurePath;
    }

    override protected function htmlLocationChange(event:Event):void {
      super.htmlLocationChange(event);

      if (!htmlWindow || htmlWindow.location == '' ||
        htmlWindow.location == location || closed) return;

      if (htmlWindow.location.indexOf(NextPath) == 0)
        hide(true);
      else if (htmlWindow.location.indexOf(FailurePath) == 0)
        hide(false);
      // Sometimes we get kicked to home.php, which is basically failure
      else if (htmlWindow.location.indexOf("home.php") != -1)
        hide(false);
      else transition();
    }
  }
}
