/**
 * http://wiki.developers.facebook.com/index.php/Events.cancel
 * Feb 18/09
 */ 
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
package com.facebook.commands.events {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.commands.photos.UploadPhotoTypes;
	import com.facebook.data.events.CreateEventData;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.net.IUploadPhoto;
	import com.facebook.utils.FacebookDataUtils;

	use namespace facebook_internal;

	/**
	 * The CreateEvent class represents the public  
      Facebook API known as Events.create.
	 * @see http://wiki.developers.facebook.com/index.php/Events.create
	 */
	public class CreateEvent extends FacebookCall implements IUploadPhoto {

		
		public static const METHOD_NAME:String = 'events.create';
		public static const SCHEMA:Array = ['event_info', 'data'];
		
		public var event_info:CreateEventData;
		protected var _data:Object;
		protected var _uploadType:String = UploadPhotoTypes.PNG;
		protected var _uploadQuality:uint = 80;		
		
		public function CreateEvent(event_info:CreateEventData, data:Object = null) {
			super(METHOD_NAME);
			
			this.event_info = event_info;
			this.data = data;
		}
		
		public function get data():Object { return _data; }
		public function set data(value:Object):void { _data = value; }
		
		public function get uploadType():String { return _uploadType; }
		public function set uploadType(value:String):void { _uploadType = value; }
		
		public function get uploadQuality():uint { return _uploadQuality; }
		public function set uploadQuality(value:uint):void { _uploadQuality = value; }
		
		
		override facebook_internal function initialize():void {
			
			var o:Object = {}
			for each(var n:String in event_info.schema) {
				var value:Object = event_info[n];
				if (value is Date) { value = FacebookDataUtils.toDateString(value as Date); }
				o[n] = value;
			}
			
			applySchema(SCHEMA, JSON.encode(o), data);
			super.facebook_internal::initialize();
		}
	}
}