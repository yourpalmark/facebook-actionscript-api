/**
 * http://wiki.developers.facebook.com/index.php/Data.setUserPreference
 * Feb 19/09
 */
package com.facebook.commands.batch {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.data.InternalErrorMessages;
	import com.facebook.data.batch.BatchCollection;
	import com.facebook.delegates.RequestHelper;
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;
	
	import flash.net.URLVariables;
	
	use namespace facebook_internal;
	
	/**
	 * The BatchRun class represents the public  
      Facebook API known as Batch.run.
	 * @see http://wiki.developers.facebook.com/index.php/Batch.run
	 */
	public class BatchRun extends FacebookCall {

		
		public static var METHOD_NAME:String = 'batch.run';
		public static var SCHEMA:Array = ['method_feed', 'serial_only'];
		
		public var method_feed:BatchCollection;
		public var serial_only:Boolean;
		
		use namespace facebook_internal;
		
		public function BatchRun(method_feed:BatchCollection, serial_only:Boolean = false) {
			super(METHOD_NAME);
			
			if (method_feed.length > 20) {
				throw new RangeError(InternalErrorMessages.BATCH_RUN_RANGE_ERROR);
			}
			
			this.method_feed = method_feed;
			this.serial_only = serial_only;
		}
		
		override facebook_internal function initialize():void {
			var actualFeed:Array = [];
			var l:uint = method_feed.length;
			
			for (var i:uint=0;i<l;i++) {
				var call:FacebookCall = method_feed.getItemAt(i) as FacebookCall;
				call.session = session;
				call.facebook_internal::initialize();
				
				RequestHelper.formatRequest(call);
				
				var urlVars:URLVariables = call.args;
				actualFeed.push(urlVars.toString());
			}
			
			var methodFeed:String = JSON.encode(actualFeed);
			applySchema(SCHEMA, methodFeed, serial_only);
			super.initialize();
			super.facebook_internal::initialize();
		}
	}
}