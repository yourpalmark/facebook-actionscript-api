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
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetObjects class represents the public  
      Facebook API known as Data.getObjects.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getObjects
	 */
	public class GetObjects extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getObjects';
		public static const SCHEMA:Array = ['obj_ids','prop_names'];
		
		public var obj_ids:Array;
		public var prop_names:Array;
		
		public function GetObjects(obj_ids:Array, prop_names:Array=null) {
			super(METHOD_NAME);
			
			this.obj_ids = obj_ids;
			this.prop_names = prop_names;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(obj_ids), FacebookDataUtils.toArrayString(prop_names));
			super.facebook_internal::initialize();
		}
	}
}