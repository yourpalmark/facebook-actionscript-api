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
	
	import com.facebook.data.FacebookData;
	import com.facebook.data.FacebookLocation;
	
	[Bindable]
	public class FacebookUser extends FacebookData {
		
		public var uid:String;
		
		public var isLoggedInUser:Boolean;
		
		public var name:String = "";
		public var first_name:String = "";
		public var last_name:String = "";
		
		public var pic:String;
		public var pic_big:String;
		public var pic_small:String;
		public var pic_square:String;

		public var sex:String;
		public var birthday:String;
		public var birthdayDate:Date;
		
		public var about_me:String;
		public var activities:String;
		public var affiliations:Array;
		public var books:String;
		public var interests:String;
		public var movies:String;
		public var music:String;
		public var political:String;
		public var quotes:String;
		public var religion:String
		public var tv:String;
		public var status:StatusData;

		public var networkAffiliations:Array;

		public var education_history:Array;

		public var timezone:int;
		public var current_location:FacebookLocation;
		public var hometown_location:FacebookLocation;
		
		public var hs_info:String;
		public var hs1_name:String;
		public var hs2_name:String;
		public var grad_year:String;
		public var hs1_id:int;
		public var hs2_id:int;
		
		public var is_app_user:Boolean;
		public var has_added_app:Boolean;
		
		public var meeting_for:Array;
		public var meeting_sex:Array;
		
		public var relationship_status:String;
		public var significant_other_id:int;

		public var profile_update_time:Date;

		public var notes_count:int;
		public var wall_count:int;
		
		public var work_history:Array;
		
		public var profile_url:String;
		
		public var proxied_email:String;
		public var pic_square_with_logo:String;
		public var pic_small_with_logo:String;
		public var pic_with_logo:String;
		public var pic_big_with_logo:String;
		public var locale:String; 
		public var email_hashes:Array;
		
 		public function FacebookUser():void {
			super();
		}
		
	}
}