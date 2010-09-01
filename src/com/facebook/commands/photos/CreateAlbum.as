/**
 * http://wiki.developers.facebook.com/index.php/Photos.createAlbum
 * Feb 16/09
 * 
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
package com.facebook.commands.photos {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The CreateAlbum class represents the public  
      Facebook API known as Photos.createAlbum.
	 * @see http://wiki.developers.facebook.com/index.php/Photos.createAlbum
	 */
	public class CreateAlbum extends FacebookCall {
		
		public static const METHOD_NAME:String = 'photos.createAlbum';
		public static const SCHEMA:Array = ['name','location','description','visible','uid'];
		
		public var name:String;
		public var location:String;
		public var description:String;
		public var visible:String;
		public var uid:String;
		
		public function CreateAlbum(name:String, location:String=null, description:String=null, visible:String=null, uid:String=null) {
			super(METHOD_NAME);
			
			this.name = name;
			this.location = location;
			this.description = description;
			this.visible = visible;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, location, description, visible, uid);
			super.facebook_internal::initialize();
		}
	}
}