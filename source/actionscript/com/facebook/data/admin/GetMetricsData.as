package com.facebook.data.admin {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetMetricsData extends FacebookData {
		
		public var metricsCollection:MetricsDataCollection;
		
		public function GetMetricsData() {
			super();
		}
		
	}
}