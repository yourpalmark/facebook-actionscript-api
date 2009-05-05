/**
 * ENUM class that defines all the possible error codes returned from the Facebook API
 * As described in http://wiki.developers.facebook.com/index.php/Error_codes
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
package com.facebook.data {
	
	[Bindable]
	public class FacebookErrorCodes {
		
		public static const SERVER_ERROR:Number = -1; //Defines a server error from Flash. 
		
		public static const API_EC_SUCCESS:Number = 0;//Success 	 (all);
		public static const API_EC_UNKNOWN:Number = 1;//An unknown error occurred 	(all)
		public static const API_EC_SERVICE:Number = 2;//Service temporarily unavailable 	(all)
		public static const API_EC_METHOD:Number = 3;//Unknown method
		public static const API_EC_TOO_MANY_CALLS:Number = 4;//Application request limit reached 	(all)
		public static const API_EC_BAD_IP:Number = 5;//Unauthorized source IP address 	(all)
		public static const API_EC_HOST_API:Number = 6;//This method must run on api.facebook.com 	(all)
		public static const API_EC_HOST_UP:Number = 7;//This method must run on api-video.facebook.com
		public static const API_EC_SECURE:Number = 8;//This method requires an HTTPS connection
		public static const API_EC_RATE:Number = 9;//User is performing too many actions
		public static const API_EC_PERMISSION_DENIED:Number = 10;//Application does not have permission for this action
		public static const API_EC_DEPRECATED:Number = 11;//This method is deprecated
		public static const API_EC_VERSION:Number = 12;//This API version is deprecated 
		
	}
}