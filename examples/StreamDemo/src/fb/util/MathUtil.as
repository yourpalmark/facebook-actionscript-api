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
package fb.util {
  public final class MathUtil {
    // returns bounded n to the min and max
    public static function clamp(n:Number, min:Number=0, max:Number=1):Number {
      if (n < min) {
        return min;
      }
      if (n > max) {
        return max;
      }
      return n;
    }

    // A simple number shaper which takes a number 0-1 and returning a
    // number 0-1
    public static function invCos(x:Number):Number {
      return 1 - (0.5 * (Math.cos(x*Math.PI) + 1));
    }

    public static function and(... bools):Boolean {
      for each (var b:Boolean in bools) if (!b) return false;
      return true;
    }

    public static function or(... bools):Boolean {
      for each (var b:Boolean in bools) if (b) return true;
      return false;
    }

    public static function xor(... bools):Boolean {
      var foundTruth:Boolean = false;
      for each (var b:Boolean in bools) if (b) {
        if (foundTruth) return false;
        foundTruth = true;
      }
      return foundTruth;
    }

    // returns an ordinal number
    public static function ordinal(n:int):String {
      if (n > 3 && n < 21) {
        return n + 'th';
      }
      switch (n % 10) {
        case 1: return n + 'st';
        case 2: return n + 'nd';
        case 3: return n + 'rd';
        default: return n + 'th';
      }
      //return n + 'th';
    }
  }
}