/**
 * 
 * http://wiki.developers.facebook.com/index.php/Users.setStatus
 * Feb 16/09
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
package com.facebook.commands.users {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The SetStatus class represents the public  
      Facebook API known as Users.setStatus.
	 * @see http://wiki.developers.facebook.com/index.php/Users.setStatus
	 */
	public class SetStatus extends FacebookCall {

		
		public static const METHOD_NAME:String = 'users.setStatus';
		public static const SCHEMA:Array = ['status', 'clear', 'status_includes_verb', 'uid'];
		
		public var status:String;
		public var clear:Boolean;
		public var status_includes_verb:Boolean;
		public var uid:String;
		
		public function SetStatus(status:String = null, clear:Boolean = false, status_includes_verb:Boolean = false, uid:String = null) {
			super(METHOD_NAME);
			
			this.status = status;
			this.clear = clear;
			this.status_includes_verb = status_includes_verb;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, status, clear, status_includes_verb, uid);
			super.facebook_internal::initialize();
		}
	} 
}