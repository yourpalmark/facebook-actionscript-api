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
package com.facebook.utils {
	
	import flash.system.Capabilities;
	
	public class PlayerUtils {
		
		protected static var versionObj:Object;
		
		public static function get platform():String {
			return parseVersionString().platform;
		}
		
		public static function get majorVersion():Number {
			return parseVersionString().majorVersion;
		}
		
		public static function get minorVersion():Number {
			return parseVersionString().minorVersion;
		}
		
		public static function get buildNumber():Number {
			return parseVersionString().buildNumber;
		}
		
		public static function get internalBuildNumber():Number {
			return parseVersionString().internalBuildNumber;
		}
		
		public static function parseVersionString():Object {
			if (versionObj != null) { return versionObj; }
			
			var version:String = Capabilities.version;
			versionObj = {};
			
			var peices1:Array = version.split(' '); 
			versionObj.platform = peices1[0];
			peices1.shift();
			peices1 = peices1[0].split(',');
			versionObj.majorVersion =  Number(peices1[0]);
			versionObj.minorVersion =  Number(peices1[1]);
			versionObj.buildNumber =  Number(peices1[2]);
			versionObj.internalBuildNumber =  Number(peices1[3]);
			return versionObj;
		}

	}
}