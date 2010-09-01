/**
 * http://wiki.developers.facebook.com/index.php/Video.uploadVideo
 * September 22/09
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
package com.facebook.commands.video {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.net.IUploadVideo;

	use namespace facebook_internal;
	
	/**
	 * The UploadVideo class represents the public  
      Facebook API known as Video.upload.
	 * @see http://wiki.developers.facebook.com/index.php/Video.upload
	 */
	public class UploadVideo extends FacebookCall implements IUploadVideo {

		public static const METHOD_NAME:String = 'video.upload';
		public static const SCHEMA:Array = ['data', 'title', 'description'];
		
		protected var _data:Object;
		protected var _title:String;
		protected var _description:String;
		
		protected var _ext:String;
		
		public function set data(value:Object):void { _data = value; }
		public function get data():Object { return _data; }
		
		public function set title(value:String):void { _title = value; }
		public function get title():String { return _title; }
		
		/**
		 * Used to change type of Uploaded videos.
		 * @see UploadVideoTypes
		 * 
		 */
		public function set ext(value:String):void { _ext = value; }
		public function get ext():String { return _ext; }
		
		public function set description(value:String):void { _description = value; }
		public function get description():String { return _description; }
		
		public function UploadVideo(ext:String, data:Object, title:String = null, description:String = null) {
			super(METHOD_NAME);
						
			this.ext = ext;
			this.data = data;			
			this.title = title;
			this.description = description;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, data, title, description);
			super.facebook_internal::initialize();
		}
	}
}