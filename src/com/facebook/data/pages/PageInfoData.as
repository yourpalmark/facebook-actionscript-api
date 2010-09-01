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
package com.facebook.data.pages {
	
	import com.facebook.data.FacebookLocation;
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class PageInfoData extends EventDispatcher {
		
		public var page_id:Number;
		public var name:String;
		public var pic_small:String;
		public var pic_big:String;
		public var pic_square:String;
		public var pic_large:String;
		public var type:String;
		public var website:String;
		public var location:FacebookLocation;
		public var hours:String;
		public var band_members:String;
		public var bio:String;
		public var hometown:String;
		public var genre:String;
		public var record_label:String;
		public var influences:String;
		public var has_added_app:Boolean;
		public var founded:String;
		public var company_overview:String;
		public var mission:String;
		public var products:String;
		public var release_date:String;
		public var starring:String;
		public var written_by:String;
		public var directed_by:String;
		public var produced_by:String;
		public var studio:String;
		public var awards:String;
		public var plot_outline:String;
		public var network:String;
		public var season:String;
		public var schedule:String;
		
		public function PageInfoData() {
			super();
		}

	}
}