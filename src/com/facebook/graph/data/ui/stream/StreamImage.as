package com.facebook.graph.data.ui.stream
{
	public class StreamImage extends StreamMedia
	{
		/**
		 * The photo URL.
		 */
		public var src:String;
		
		/**
		 * The URL where a user should be taken if he or she clicks the photo.
		 */
		public var href:String;
		
		public function StreamImage()
		{
			super();
			
			type = StreamMediaType.IMAGE;
		}
		
		override public function toObject():Object
		{
			var object:Object = super.toObject();
			object.src = src;
			object.href = href;
			return object;
		}
		
	}
}