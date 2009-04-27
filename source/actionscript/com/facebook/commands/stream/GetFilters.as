package com.facebook.commands.stream {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	public class GetFilters extends FacebookCall {
		
		public static const METHOD_NAME:String = 'stream.getFilters';
		public static const SCHEMA:Array = ['uid'];
		
		public var uid:String;
		
		public function GetFilters(uid:String = null) {
			super(METHOD_NAME);
			
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid);
			super.facebook_internal::initialize();
		}
		
	}
}