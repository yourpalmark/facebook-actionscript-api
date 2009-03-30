package com.facebook.data.batch {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class BatchResult extends FacebookData {
		
		/**
		 * Array of result returned from the Batch call.
		 * Each element will corrospond to the order you send the batch commands.
		 * They will all be either FaceookData or FacebookError objects based on the success of each call.
		 * 
		 */
		public var results:Array;
		
		public function BatchResult() {
			super();
		}
		
	}
}