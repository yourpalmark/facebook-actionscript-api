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
