/**
 * 
 * Abstract class created due to the fact that when submitting a type leaf/container, was generating a invalid parameter error.
 * Should use one of the more specific TagClasses to register tag data (ex:LeafTagData or ContainerTagData).
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
package com.facebook.data.fbml {
	
	import com.facebook.data.fbml.AttributeCollection;
	
	[Bindable]
	public class AbstractTagData {
		
		public var name:String;
		public var type:String;
		public var description:String;
		public var is_public:String;
		public var attributes:AttributeCollection;
		public var header_fbml:String;
		public var footer_fbml:String;
		
		public function AbstractTagData(name:String, header_fbml:String, footer_fbml:String, type:String, 
										description:String = '', is_public:String = '',
										attributes:AttributeCollection = null) {
											
			this.name = name;
			this.type = type;
			this.description = description;
			this.is_public = is_public;
			this.header_fbml = header_fbml;
			this.footer_fbml = footer_fbml;
			this.attributes = attributes;
		}

	}
}