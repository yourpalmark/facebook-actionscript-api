package com.facebook.data.admin {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class MetricsDataCollection extends FacebookArrayCollection {
		
		public function MetricsDataCollection() {
			super(null, MetricsData);
		}
		
	}
}