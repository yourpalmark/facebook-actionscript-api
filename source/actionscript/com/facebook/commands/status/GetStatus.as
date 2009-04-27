package com.facebook.commands.status {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;
	
	use namespace facebook_internal;
	
	public class GetStatus extends FacebookCall {
		
		public static const METHOD_NAME:String = 'status.get';
		public static const SCHEMA:Array = ['uid', 'limit'];
		
		public var uid:String;
		public var limit:uint;
		
		public function GetStatus(uid:String, limit:uint = 100) {
			this.uid = uid;
			this.limit = limit;
			
			super(METHOD_NAME);
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid, limit);
			super.facebook_internal::initialize();
		}
		
	}
}