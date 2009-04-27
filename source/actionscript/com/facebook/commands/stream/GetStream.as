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

package com.facebook.commands.stream {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	
	use namespace facebook_internal;

	public class GetStream extends FacebookCall {
		
		public static const METHOD_NAME:String = 'stream.get';
		public static const SCHEMA:Array = ['viewer_id', 'source_ids', 'start_time', 'end_time', 'limit', 'filter_key'];
		
		public var viewer_id:String;
		public var source_ids:Array;
		public var start_time:Date;
		public var end_time:Date;
		public var limit:uint;
		public var filter_key:String;
		
		public function GetStream(viewer_id:String, source_ids:Array = null, start_time:Date = null, end_time:Date = null, limit:uint = 30, filter_key:String = null) {
			this.viewer_id = viewer_id;
			this.source_ids = source_ids;
			this.start_time = start_time;
			this.end_time = end_time;
			this.limit = limit;
			this.filter_key = filter_key;
			
			super(METHOD_NAME);
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, viewer_id, FacebookDataUtils.toArrayString(source_ids), FacebookDataUtils.toDateString(start_time), FacebookDataUtils.toDateString(end_time), limit, filter_key);
			super.facebook_internal::initialize();
		}
		
	}
}