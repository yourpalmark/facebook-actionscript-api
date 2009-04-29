package com.facebook.streamdemo.data {
	
	public class NotificationChangeData {
		
		public static const NOTIFICATION:String = 'notification';
		public static const POKE:String = 'poke';
		public static const MESSAGE:String = 'message';
		public static const REQUEST:String = 'request';
		
		public var time:Date;
		public var type:String;
		public var count:uint;
		
		public function NotificationChangeData() {
			
		}

	}
}