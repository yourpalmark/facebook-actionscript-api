/**
 * 	@author Peter "sHTiF" Stefcek
 *  @description Class that can build MIME multipart messages.
 */
package com.shtif.web
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class MIMEConstructor
	{
		private var boundary:String = "shtifmimeboundary";
		private var postData:ByteArray;
		
		public function MIMEConstructor():void
		{
			initPostData();
		}
		
		public function setBoundary(p_boundary:String):void
		{
			boundary = p_boundary;
		}
		
		public function getBoundary():String
		{
			return boundary;
		}
		
		private function writeLineBreak():void 
		{
			postData.writeShort(0x0d0a);
		}
		
		private function writeQuotationMark():void 
		{
			postData.writeByte(0x22);
		}
		
		private function writeDoubleDash():void
		{
			postData.writeShort(0x2d2d);
		}
		
		private function writeBoundary():void 
		{
			writeDoubleDash();
			for (var i:Number=0; i<boundary.length; i++) 
			{
				postData.writeByte(boundary.charCodeAt(i));
			}
		}
		
		public function initPostData():void
		{
			postData = new ByteArray();
			postData.endian = Endian.BIG_ENDIAN;
		}
		
		public function writePostData(p_name:String, p_value:String):void
		{
			var bytes:String;
			writeBoundary();
			writeLineBreak();
			bytes = 'Content-Disposition: form-data; name="' + p_name + '"';
			for (var i:Number=0; i<bytes.length; i++) 
			{
				postData.writeByte( bytes.charCodeAt(i) );
			}
			writeLineBreak();
			writeLineBreak();
			postData.writeUTFBytes(p_value);
			writeLineBreak();
		}
		
		public function writeFileData(p_filename:String, p_data:ByteArray):void
		{
			var bytes:String;
			writeBoundary();
			writeLineBreak();
			bytes = 'Content-Disposition: form-data; filename="';
			for (var i:Number=0; i<bytes.length; i++) 
			{
				postData.writeByte(bytes.charCodeAt(i));
			}
			postData.writeUTFBytes(p_filename);
			writeQuotationMark();
			writeLineBreak();
			bytes = 'Content-Type: image/jpg';
			for (i=0; i<bytes.length; i++)
			{
				postData.writeByte(bytes.charCodeAt(i));
			}
			writeLineBreak();
			writeLineBreak();
			p_data.position = 0;
			postData.writeBytes(p_data, 0, p_data.length);
			writeLineBreak();
		}
		
		public function closePostData():void
		{
			writeBoundary();
			writeDoubleDash();
		}
		
		public function getPostData():ByteArray
		{
			postData.position = 0;
			return postData;
		}
	}
}