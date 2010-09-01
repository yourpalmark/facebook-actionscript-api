/**
 * http://wiki.developers.facebook.com/index.php/Events.rsvp
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
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The RSVP class represents the public  
      Facebook API known as Events.rsvp.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Events.rsvp
	 */
	public class RSVP extends FacebookCall {

		
		public static const METHOD_NAME:String = 'events.rsvp';
		public static const SCHEMA:Array = ['eid', 'rsvp_status'];
		
		public var eid:String;
		public var rsvp_status:String;
		
		public function RSVP(eid:String, rsvp_status:String) {
			super(METHOD_NAME);
			
			this.eid = eid;
			this.rsvp_status = rsvp_status;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, eid, rsvp_status);
			super.facebook_internal::initialize();
		}
	}
}