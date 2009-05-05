/**
 * http://wiki.developers.facebook.com/index.php/Data.defineAssociation
 * FEB 24.09
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
	 * The RenameAssociation class represents the public  
      Facebook API known as Data.renameAssociation.
	 * @see http://wiki.developers.facebook.com/index.php/Data.renameAssociation
	 */
	public class RenameAssociation extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.renameAssociation';
		public static const SCHEMA:Array = ['name','new_name','new_alias1','new_alias2'];
		
		public var name:String;
		public var new_name:String;
		public var new_alias1:String;
		public var new_alias2:String;
		
		public function RenameAssociation(name:String, new_name:String='', new_alias1:String='', new_alias2:String='') {
			super(METHOD_NAME);
			
			if (ValidationUtils.isDataObjectTypeValid(new_name) == false ) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:new_name}));
			}
			if (ValidationUtils.isDataObjectTypeValid(new_alias1) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:new_alias1}));
			}
			if (ValidationUtils.isDataObjectTypeValid(new_alias2) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:new_alias2}));
			}
			
			this.name = name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, new_name, new_alias1, new_alias2); 
			super.facebook_internal::initialize();
		}
	}
}