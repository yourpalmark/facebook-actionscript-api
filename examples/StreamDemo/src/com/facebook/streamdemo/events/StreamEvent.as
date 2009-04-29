package com.facebook.streamdemo.events {
	
	import flash.events.Event;

	public class StreamEvent extends Event {
		
		public static const LOAD_FRIENDS:String = 'loadFriends';
		public static const STREAM_LOAD:String = 'streamLoad';
		public static const STREAM_LOAD_ERROR:String = 'streamLoadError';
		public static const COMMENT_ADDED:String = 'commentAdded';
		public static const COMMENT_REMOVED:String = 'commentRemoved';
		public static const REMOVE_ROW:String = 'removeRow'; 
		public static const LIKE_ADDED:String = 'likeAdded';
		public static const LIKE_REMOVED:String = 'likeRemoved';
		public static const REFRESH:String = 'refresh';
		
		public var data:Object;
		
		public function StreamEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:Object = null) {
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new StreamEvent(type, bubbles, cancelable, data);
		}
		
	}
}