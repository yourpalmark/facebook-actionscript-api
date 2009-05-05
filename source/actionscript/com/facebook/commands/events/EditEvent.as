/**
 * http://wiki.developers.facebook.com/index.php/Events.edit
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
	import com.facebook.data.events.EditEventData;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;

	use namespace facebook_internal;

	/**
	 * The EditEvent class represents the public  
      Facebook API known as Events.edit.
	 * @see http://wiki.developers.facebook.com/index.php/Events.edit
	 */
	public class EditEvent extends FacebookCall {

		
		public static const METHOD_NAME:String = 'events.edit';
		public static const SCHEMA:Array = ['eid', 'event_info'];
		
		public var eid:String;
		public var event_info:EditEventData;
		
		public function EditEvent(eid:String, event_info:EditEventData) {
			super(METHOD_NAME);
			
			this.eid = eid;
			this.event_info = event_info;
		}
		
		override facebook_internal function initialize():void {
			
			var o:Object = {}
			for each(var n:String in event_info.schema) {
				var value:Object = event_info[n];
				if (value is Date) { value = FacebookDataUtils.toDateString(value as Date); }
				o[n] = value;
			}
			
			applySchema(SCHEMA, eid, JSON.encode(event_info));
			super.facebook_internal::initialize();
		}
	}
}