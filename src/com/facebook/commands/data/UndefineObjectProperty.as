/**
 * http://wiki.developers.facebook.com/index.php/Data.undefineObjectProperty
 * Feb 20/09
 * ** (from (facebook.com) Note: Support for this method is temporarily disabled until we support user-level permissions. You can still make this call, but you must include your application secret.
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
	 * The UndefineObjectProperty class represents the public  
      Facebook API known as Data.undefineObjectProperty.
	 * @see http://wiki.developers.facebook.com/index.php/Data.undefineObjectProperty
	 */
	public class UndefineObjectProperty extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.undefineObjectProperty';
		public static const SCHEMA:Array = ['obj_type', 'prop_name'];
		
		public var obj_type:String;
		public var prop_name:String;
		
		public function UndefineObjectProperty(obj_type:String, prop_name:String) {
			super(METHOD_NAME);
			
			if (ValidationUtils.isDataObjectTypeValid(obj_type) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:obj_type}));
			}
			
			if (ValidationUtils.isDataObjectTypeValid(prop_name) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:prop_name}));
			}
			
			this.obj_type = obj_type;
			this.prop_name = prop_name;
		}	
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type, prop_name);
			super.facebook_internal::initialize();
		}
	}
}