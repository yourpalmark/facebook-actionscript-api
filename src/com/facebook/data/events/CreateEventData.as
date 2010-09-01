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
package com.facebook.data.events {
	
	import com.facebook.facebook_internal;
	
	use namespace facebook_internal;
	
	[Bindable]
	public class CreateEventData {
	
	
		//Required
		public var name:String;
		
		/**
		 * @see EventCategoriesValues
		 * 
		 */
		public var category:String;
		
		/**
		 * @see EventSubCategoriesValues
		 * 
		 */
		public var subcategory:String;
		public var host:String;
		public var location:String;
		public var city:String;
		public var start_time:Date;
		public var end_time:Date;
		
		facebook_internal var schema:Array;
		
		//Optional
		public var street:String;
		public var phone:String;
		public var email:String;
		public var page_id:Number;
		public var description:String;
		
		/**
		 * @see CreateEventPrivacyTypeValues
		 * 
		 */
		public var privacy_type:String;
		public var tagline:String;
    
		public function CreateEventData(
										name:String, category:String, subcategory:String, host:String, location:String, city:String, start_time:Date, end_time:Date,
										street:String = null, phone:String = null, email:String = null, page_id:Number = NaN, description:String = null, privacy_type:String = null, tagline:String = null 
										) {
			
			schema = ['name', 'category', 'subcategory', 
					  'host', 'location', 'city', 'start_time', 
					  'end_time', 'street', 'phone', 'email', 
					  'page_id', 'description', 'privacy_type', 'tagline'];
			
			this.name = name;
			this.category = category;
			this.subcategory = subcategory;
			this.host = host;
			this.location = location;
			this.city = city;
			this.start_time = start_time;
			this.end_time = end_time;
			
			//Optional
			this.street = street
			this.phone = phone;
			this.email= email;
			this.page_id = page_id;
			this.description = description;
			this.privacy_type = privacy_type;
			this.tagline = tagline;
		}
		//getter /setter for the dates
	}
}