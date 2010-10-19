package com.facebook.graph.data.ui.stream
{
	public class StreamMedia
	{
		/**
		 * Stream media can be one of the following: image, flash, or mp3;
		 * These media types render photos, Flash objects, and music, respectively.
		 */
		public var type:String;
		
		public function StreamMedia()
		{
		}
		
		public function toObject():Object
		{
			return { type: type };
		}
		
	}
}