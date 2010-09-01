/**
 * Values for admin.getAllocation command
 * As defined in http://wiki.developers.facebook.com/index.php/Admin.getAllocation, Feb 3, 2009
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
package com.facebook.data.admin {
	
	[Bindable]
	public class GetAllocationValues {
		
		/**
		 * The number of notifications your application can send on behalf of a user per day. These are user-to-user notifications. 
		 * 
		 */
		public static const NOTIFICATIONS_PER_DAY:String = 'notifications_per_day';
		
		/**
		 * The number of notifications your application can send to a user per week. These are application-to-user notifications. 
		 * 
		 */
		public static const ANNOUNCEMENT_NOTIFICATIONS_PER_WEEK:String = 'announcement_notifications_per_week';
		
		/**
		 * The number of requests your application can send on behalf of a user per day. 
		 * 
		 */
		public static const REQUESTS_PER_DAY:String = 'requests_per_day';
		
		/**
		 * The number of email messages your application can send to a user per day. 
		 * 
		 */
		public static const EMAILS_PER_DAY:String = 'emails_per_day';
		
		/**
		 * The location of the disable message within emails sent by your application. '1' is the bottom of the message and '2' is the top of the message.
		 * 
		 */
		public static const EMAIL_DISABLE_MESSAGE_LOCATION:String = 'email_disable_message_location';
		
	}
}