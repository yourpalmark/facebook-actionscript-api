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
		
		public function writeFileData(filename:String, fileData:ByteArray):void {
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
			
			bytes = 'Content-Type: image/jpg';
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