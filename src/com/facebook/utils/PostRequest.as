/*
  Copyright (c) 2009, Adobe Systems Incorporated
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
package com.facebook.utils {
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class PostRequest {
		
		protected var _boundary:String = "-----";
		protected var postData:ByteArray;
		
		public function PostRequest() {
			createPostData();
		}
		
		public function set boundary(value:String):void { _boundary = value; }
		public function get boundary():String { return _boundary; }
		
		public function createPostData():void {
			postData = new ByteArray();
			postData.endian = Endian.BIG_ENDIAN;
		}
		
		public function writePostData(name:String, value:String):void {
			var bytes:String;
			
			writeBoundary();
			writeLineBreak();
			
			bytes = 'Content-Disposition: form-data; name="' + name + '"';
			
			var l:uint = bytes.length;
			for (var i:Number=0; i<l; i++)  {
				postData.writeByte( bytes.charCodeAt(i) );
			}
			
			writeLineBreak();
			writeLineBreak();
			
			postData.writeUTFBytes(value);
			
			writeLineBreak();
		}
		
		public function writeFileData(filename:String, fileData:ByteArray, contentType:String):void {
			var bytes:String;
			
			writeBoundary();
			writeLineBreak();
			
			bytes = 'Content-Disposition: form-data; filename="';
			for (var i:Number=0; i<bytes.length; i++)  {
				postData.writeByte(bytes.charCodeAt(i));
			}
			postData.writeUTFBytes(filename);
			
			writeQuotationMark();
			writeLineBreak();
			
			bytes = contentType;
			for (i=0; i<bytes.length; i++) {
				postData.writeByte(bytes.charCodeAt(i));
			}
			
			writeLineBreak();
			writeLineBreak();
			
			fileData.position = 0;
			postData.writeBytes(fileData, 0, fileData.length);
			
			writeLineBreak();
		}
		
		public function getPostData():ByteArray {
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
			
			for (var i:Number=0; i<boundary.length; i++)  {
				postData.writeByte(boundary.charCodeAt(i));
			}
			
		}

	}
}