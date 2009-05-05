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
	
	import com.adobe.crypto.MD5;
	import flash.utils.ByteArray;
	
	public class EmailHashUtil {
		
		protected static const crcTable:Array = createCRCTable();
		
		public static function createHash(email:String):String {
			var normalizedEmail:String;
			
			normalizedEmail = email.replace(/\s/ig,'');
			normalizedEmail = normalizedEmail.toLowerCase();
			
			var emailBytes:ByteArray = new ByteArray();
			emailBytes.writeUTFBytes(normalizedEmail);
			
			var crc32Value:uint = CRC32(emailBytes, 0, emailBytes.length);
			var md5Value:String = MD5.hash(normalizedEmail);
			
			return crc32Value + '_' + md5Value; 
		}
		
		protected static function CRC32(data:ByteArray, start:uint = 0, len:uint = 0):uint {
			if (start >= data.length) { start = data.length; }
			if (len == 0) { len = data.length - start; }
			if (len + start > data.length) { len = data.length - start; }
			
			var c:uint = 0xffffffff;
			for (var i:uint=start; i<len; i++) {
				c = uint(crcTable[(c ^ data[i]) & 0xff]) ^ (c >>> 8);
			}
			
			return (c ^ 0xffffffff);
		}
		
		protected static function createCRCTable():Array {
			var table:Array = [];
			var c:uint;
			
			for (var i:uint=0; i<256; i++) {
				c = i;
				for (var j:uint=0; j<8; j++) {
					if (c & 1) {
						c = 0xEDB88320 ^ (c >>> 1);
					} else {
						c >>>= 1;
					}
				}
				table.push(c);
			}
			
			return table;
		}
		
	}
}
