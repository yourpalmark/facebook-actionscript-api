/**
 * http://wiki.developers.facebook.com/index.php/Admin.getMetrics
 * Feb 10/09
 */
package com.facebook.commands.admin {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	
	use namespace facebook_internal;
	
	/**
	 * The GetMetrics class represents the public  
      Facebook API known as Admin.getMetrics.
	 * @see http://wiki.developers.facebook.com/index.php/Admin.getMetrics
	 */
	public class GetMetrics extends FacebookCall {

		
		public static const METHOD_NAME:String = 'admin.getMetrics';
		public static const SCHEMA:Array = ['start_time', 'end_time', 'period', 'metrics'];
		
		public var start_time:Date;
		public var end_time:Date;
		public var period:String;
		public var metrics:Array;
		
		public function GetMetrics(start_time:Date, end_time:Date, period:String, metrics:Array) {
			super(METHOD_NAME);
			
			this.start_time = start_time;
			this.end_time = end_time;
			this.period = period;
			this.metrics = metrics;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toDateString(start_time), FacebookDataUtils.toDateString(end_time), period, JSON.encode(metrics));
			super.facebook_internal::initialize();
		}
	}
}