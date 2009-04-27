package com.facebook.data.stream {
	
	[Bindable]
	public class StreamMediaData {
		
		public var href:String;
		
		/**
		 * @see com.facebook.data.stream.MediaTypes
		 * 
		 */
		public var type:String;
		
		public var src:String;
		
		//These values are optional
		public var alt:String;
		public var photo:PhotoMedia;
		public var video:VideoMedia;
		
		public function StreamMediaData() {
			
		}

	}
}