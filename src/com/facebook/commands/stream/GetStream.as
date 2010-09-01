/*
viewer_id: int (required)
	The user ID or Facebook Page ID for whom you are fetching stream data.
	You can pass 0 for this parameter to retrieve publicly viewable information.
	However, desktop applications must always specify a viewer as well as a session key.
	
source_ids: array (optional)
	The list of IDs for the users whose proﬁles you want to fetch.
	Defaults to all the logged in users friends.
	
start_time: time (optional)
	The earliest rimme (in Unix time) for which to retrieve stories from the stream.
	
end_time: time (optonal)
	The latest time (in Unix time) for which to retrieve stories from the stream.
	
limit: int (optional)
	Number of stories to retrive from the Stream, Defaults to 30

filter_key: String (optional)
	- Filters posts by the specified filter.

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
package com.facebook.commands.stream {
		
	import com.adobe.serialization.json.JSON;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	
	use namespace facebook_internal;

	public class GetStream extends FacebookCall {
		
		public static const METHOD_NAME:String = 'stream.get';
		public static const SCHEMA:Array = ['viewer_id', 'source_ids', 'start_time', 'end_time', 'limit', 'filter_key', 'metadata'];
		
		public var viewer_id:String;
		public var source_ids:Array;
		public var start_time:Date;
		public var end_time:Date;
		public var limit:uint;
		public var filter_key:String;
		public var metadata:Array;
		
		public function GetStream(viewer_id:String = null, source_ids:Array = null, start_time:Date = null, end_time:Date = null, limit:uint = 30, filter_key:String = null, metadata:Array = null) {
			super(METHOD_NAME);
			
			this.viewer_id = viewer_id;
			this.source_ids = source_ids;
			this.start_time = start_time;
			this.end_time = end_time;
			this.limit = limit;
			this.filter_key = filter_key;
			this.metadata = metadata;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, viewer_id, FacebookDataUtils.toArrayString(source_ids), FacebookDataUtils.toDateString(start_time), FacebookDataUtils.toDateString(end_time), limit, filter_key, FacebookDataUtils.toArrayString(metadata));
			super.facebook_internal::initialize();
		}
		
	}
}