/**
 * http://wiki.developers.facebook.com/index.php/Data.setAssociation
 * FEB 23/09
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
package com.facebook.commands.data {

	import com.facebook.data.InternalErrorMessages;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.utils.ValidationUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The SetAssociation class represents the public  
      Facebook API known as Data.setAssociation.
	 * @see http://wiki.developers.facebook.com/index.php/Data.setAssociation
	 */
	public class SetAssociation extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.setAssociation';
		public static const SCHEMA:Array = ['name', 'obj_id1', 'obj_id2', 'data', 'assoc_time'];
		
		public var name:String;
		public var obj_id1:String;
		public var obj_id2:String;
		public var data:String;
		public var assoc_time:Date;
		
		public function SetAssociation(name:String, obj_id1:String, obj_id2:String,data:String = null, assoc_time:Date = null) {
			super(method, args);
			
			if (ValidationUtils.validateLength(data) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:data}));
			}
			
			this.name = name;
			this.obj_id1 = obj_id1;
			this.obj_id2 = obj_id2;
			this.assoc_time = assoc_time;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, obj_id1, obj_id2, data, FacebookDataUtils.toDateString(assoc_time));
			super.facebook_internal::initialize();
		}
	}
}