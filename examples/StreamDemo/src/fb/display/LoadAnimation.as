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
// Creates the "Loading" Animation used on Facebook to indicate
// network activity.
package fb.display {
  import fb.util.MathUtil;

  import flash.events.Event;

  import mx.containers.Canvas;

  public class LoadAnimation extends Canvas {

    public var fadeDuration:Number = 800;
    private var totalElapsed:Number = 0;

    public function LoadAnimation() {
      addEventListener(Event.ENTER_FRAME, update);
    }

    override public function set visible(to:Boolean):void {
      if (super.visible == to) return;
      super.visible = to;

      if (visible) {
        addEventListener(Event.ENTER_FRAME, update);
      } else {
        removeEventListener(Event.ENTER_FRAME, update);
      }
    }

    private function update(evt:Event):void {
      totalElapsed += 20;

      var cycle:Number;
      graphics.clear();

      var fullHeight:Number = Math.floor(height);
      var restHeight:Number = Math.floor(fullHeight * 0.3);

      var shapeWidth:Number = Math.round((width/3) * 0.6);
      var shapeGap:Number = Math.round((width/3) * 0.4);

      var dH:Number = fullHeight - restHeight;

      for (var i:int=0; i<3; i++) {
        cycle = (totalElapsed + (3-i) * fadeDuration*0.13) % fadeDuration;
        cycle = MathUtil.invCos(1 - MathUtil.clamp(cycle/(0.6*fadeDuration)));

        graphics.lineStyle(1, 0x576EA4, cycle*0.7+0.3, true);
        graphics.beginFill(0xB1BAD3, cycle*0.7+0.3);
        graphics.drawRoundRect(0.5 + i * (shapeGap + shapeWidth),
                               0.5 + 0.5 * (dH - cycle*dH),
                               shapeWidth,
                               restHeight + cycle * dH,
                               2);
        graphics.endFill();
      }
    }

  }
}
