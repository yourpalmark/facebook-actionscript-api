/**
 * ENUM class for all possible values for users.getInfo
 * As described in http://wiki.developers.facebook.com/index.php/Users.getInfo, as of Feb, 4 2009
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
package com.facebook.data.users {
	
	[Bindable]
	public class GetInfoFieldValues {
		
		public static const ABOUT_ME:String = "about_me";
		public static const ACTIVITIES:String = "activities";
		public static const AFFILIATIONS:String = "affiliations";
		public static const BIRTHDAY:String = "birthday";
		public static const BOOKS:String = "books";
		public static const CURRENT_LOCATION:String = "current_location";
		public static const EDUCATION_HISTORY:String = "education_history";
		public static const EMAIL_HASHES:String = 'email_hashes';
		public static const FIRST_NAME:String = "first_name";
		public static const HAS_ADDED_APP:String = "has_added_app";
		public static const HOMETOWN_LOCATION:String = "hometown_location";
		public static const HS_INFO:String = 'hs_info';
		public static const INTERESTS:String = "interests";
		public static const IS_APP_USER:String = "is_app_user";
		public static const LAST_NAME:String = "last_name";
		public static const LOCALE:String = 'locale';
		public static const MEETING_FOR:String = "meeting_for";
		public static const MEETING_SEX:String = "meeting_sex";
		public static const MOVIES:String = "movies";
		public static const MUSIC:String = "music";
		public static const NAME:String = "name";
		public static const NOTES_COUNT:String = "notes_count";
		public static const PIC:String = "pic";
		public static const PIC_WITH_LOGO:String = 'pic_with_logo';
		public static const PIC_BIG:String = "pic_big";
		public static const PIC_BIG_WITH_LOGO:String = "pic_big_with_logo";
		public static const PIC_SMALL:String = "pic_small";
		public static const PIC_SMALL_WITH_LOGO:String = 'pic_small_with_logo';
		public static const PIC_SQUARE:String = "pic_square";
		public static const PIC_SQUARE_WITH_LOGO:String = "pic_square_with_logo";
		public static const POLITICAL:String = "political";
		public static const PROFILE_UPDATE_TIME:String = "profile_update_time";
		public static const PROFILE_URL:String = 'profile_url';
		public static const PROXIED_EMAIL:String = 'proxied_email';
		public static const QUOTES:String = "quotes";
		public static const RELATIONSHIP_STATUS:String = "relationship_status";
		public static const RELIGION:String = "religion";
		public static const SEX:String = "sex";
		public static const SIGNIFICANT_OTHER_ID:String = "significant_other_id";
		public static const STATUS:String = 'status';
		public static const TIMEZONE:String = "timezone";
		public static const TV:String = "tv";
		public static const WALL_COUNT:String = "wall_count";
		public static const WORK_HISTORY:String = "work_history";
		
		/**
		 * Special value that contains all the values that do-not require a session key.
		 * 
		 */
		public static const NO_SESSION_VALUES:Array = [FIRST_NAME, LAST_NAME, NAME, LOCALE, AFFILIATIONS, PIC_SQUARE, PROFILE_URL];
		
		/**
		 * Special value that contains all the values in this class.
		 * 
		 */
		public static const ALL_VALUES:Array = [ABOUT_ME, ACTIVITIES, AFFILIATIONS, BIRTHDAY, BOOKS, CURRENT_LOCATION, EDUCATION_HISTORY, EMAIL_HASHES, FIRST_NAME, HAS_ADDED_APP, HOMETOWN_LOCATION, HS_INFO, INTERESTS, IS_APP_USER, LAST_NAME, LOCALE, MEETING_FOR, MEETING_SEX, MOVIES, MUSIC, NAME, NOTES_COUNT, PIC, PIC_WITH_LOGO, PIC_BIG, PIC_BIG_WITH_LOGO, PIC_SMALL, PIC_SMALL_WITH_LOGO, PIC_SQUARE, PIC_SQUARE_WITH_LOGO, POLITICAL, PROFILE_UPDATE_TIME, PROFILE_URL, PROXIED_EMAIL, QUOTES, RELATIONSHIP_STATUS, RELIGION, SEX, SIGNIFICANT_OTHER_ID, STATUS, TIMEZONE, TV, WALL_COUNT, WORK_HISTORY];
	}
}