/**
 * http://wiki.developers.facebook.com/index.php/Intl.getTranslations
 * September 21/09
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
package com.facebook.commands.intl {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	/**
	 * The GetTranslations class represents the public  
      Facebook API known as Intl.getTranslations.
	 * @see http://wiki.developers.facebook.com/index.php/Intl.getTranslations
	 */
	public class GetTranslations extends FacebookCall {

		public static const METHOD_NAME:String = 'intl.getTranslations';
		public static const SCHEMA:Array = ['locale', 'all'];
		
		public var locale:String;
		public var all:Boolean;
		
		public function GetTranslations(locale:String = 'en_US', all:Boolean = false) {
			super(METHOD_NAME);
			
			this.locale = locale;
			this.all = all;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, locale, all);
			super.facebook_internal::initialize();
		}
	}
}