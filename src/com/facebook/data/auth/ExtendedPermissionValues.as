/**
 * ENUM Class for Facebook.grantExtendedPermission(), method
 * http://wiki.developers.facebook.com/index.php/UsageNotes/Forms#Prompting_a_User_for_an_Extended_Permission
 * Feb 18/09
 * 
 * Last Update - April 10/09
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
package com.facebook.data.auth {
	
	[Bindable]
	public class ExtendedPermissionValues {
		
		public static const EMAIL:String = 'email';
		public static const READ_MAILBOX:String = 'read_mailbox';
		public static const OFFLINE_ACCESS:String = 'offline_access';
		public static const STATUS_UPDATE:String = 'status_update';
		public static const PHOTO_UPLOAD:String = 'photo_upload';
		public static const VIDEO_UPLOAD:String = 'video_upload';
		public static const CREATE_EVENT:String = 'create_event';
		public static const CREATE_NOTE:String = 'create_note';
		public static const RSVP_EVENT:String = 'rsvp_event';
		public static const SMS:String = 'sms';
		public static const SHARE_ITEM:String = 'share_item';
		public static const CREATE_LISTING:String = 'create_listing';
		
		/**
		 *  Lets your application post content, comments, and likes
		 * 	to a user's proﬁle and in the streams of the user's friends. 
		 * 
		 */
		public static const PUBLISH_STREAM:String = 'publish_stream';
		
		/**
		 * Permission is similar to republish_stream,
		 * but is subject to Storable_Information policies on storing user informaion.  
		 * 
		 */
		public static const READ_STREAM:String = 'read_stream';
	}
}