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
package com.facebook.commands.application {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;

	/**
	 * The GetPublicInfo class represents the public  
      Facebook API known as Application.getPublicInfo.
	 * @see http://wiki.developers.facebook.com/index.php/Application.getPublicInfo
	 */
	public class GetPublicInfo extends FacebookCall {

		
		public static const METHOD_NAME:String = 'application.getPublicInfo';
		public static const SCHEMA:Array = ['application_id','application_api_key','application_canvas_name'];
		
		public var application_id:String;
		public var application_api_key:String;
		public var application_canvas_name:String;
		
		
		public function GetPublicInfo(application_id:String=null, application_api_key:String=null, application_canvas_name:String=null) {
			super(METHOD_NAME);
			
			var hasId:Boolean = application_id != null;
			var hasKey:Boolean = application_api_key != null;
			var hasName:Boolean = application_canvas_name != null;
			
			if ((hasId && hasKey) || (hasId && hasName) || (hasKey && hasName)) {
				throw new Error("You must specify exactly one of application_id, application_api_key or application_canvas_name.");
			}
			
			this.application_id = application_id;
			this.application_api_key = application_api_key;
			this.application_canvas_name = application_canvas_name;
		}
		
		override facebook_internal function initialize():void {
			this.applySchema(SCHEMA, application_id, application_api_key, application_canvas_name);
			super.facebook_internal::initialize();
		}
	}
}