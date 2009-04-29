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
  import flash.filesystem.File;
  import flash.utils.ByteArray;
  import flash.utils.Endian;

  // Utility class builds our form-data;
  public class FBPost {
    public static const boundary:String = "-----";
    private var postData:ByteArray = new ByteArray();

    public function FBPost() {
      postData.endian = Endian.BIG_ENDIAN;
    }

    public function writePostData(name:String, value:String):void {
      var bytes:String;

      writeBoundary();
      writeLineBreak();

      bytes = 'Content-Disposition: form-data; name="' + name + '"';

      for (var i:Number=0; i < bytes.length; i++)  {
        postData.writeByte( bytes.charCodeAt(i) );
      }

      writeLineBreak();
      writeLineBreak();

      postData.writeUTFBytes(value);

      writeLineBreak();
    }

    public function writeFileData(file:File):void {
      var bytes:String;

      writeBoundary();
      writeLineBreak();

      bytes = 'Content-Disposition: form-data; filename="';
      for (var i:Number=0; i < bytes.length; i++)  {
        postData.writeByte(bytes.charCodeAt(i));
      }
      postData.writeUTFBytes(file.name);

      writeQuotationMark();
      writeLineBreak();

      bytes = 'Content-Type: image/jpg';
      for (i=0; i < bytes.length; i++) {
        postData.writeByte(bytes.charCodeAt(i));
      }

      writeLineBreak();
      writeLineBreak();

      file.data.position = 0;
      postData.writeBytes(file.data, 0, file.data.length);

      writeLineBreak();
    }

    public function get data():ByteArray {
      postData.position = 0;
      return postData;
    }

    public function close():void {
      writeBoundary();
      writeDoubleDash();
    }

    protected function writeLineBreak():void {
      postData.writeShort(0x0d0a);
    }

    protected function writeQuotationMark():void  {
      postData.writeByte(0x22);
    }

    protected function writeDoubleDash():void {
      postData.writeShort(0x2d2d);
    }

    protected function writeBoundary():void  {
      writeDoubleDash();

      for (var i:Number=0; i < boundary.length; i++)  {
        postData.writeByte(boundary.charCodeAt(i));
      }
    }

  }
}
