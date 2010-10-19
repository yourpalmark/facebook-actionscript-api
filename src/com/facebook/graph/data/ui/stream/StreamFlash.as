package com.facebook.graph.data.ui.stream
{
	public class StreamFlash extends StreamMedia
	{
		/**
		 * The URL of the Flash object to be rendered.
		 */
		public var swfsrc:String;
		
		/**
		 * The URL of a photo that should be displayed in place of the Flash
		 * object until the user clicks to prompt the Flash object to play.
		 */
		public var imgsrc:String;
		
		/**
		 * The width of the photo and Flash object in the stream.
		 * By default, the photo and the Flash object are rendered in a space up to 90 pixels.
		 * The width must be an integer between 30 and 90, inclusive.
		 */
		public var width:int;
		
		/**
		 * The height of the photo and Flash object in the stream.
		 * By default, the photo and the Flash object are rendered in a space up to 90 pixels.
		 * The height must be an integer between 30 and 90, inclusive.
		 */
		public var height:int;
		
		/**
		 * The width of the Flash object once the user clicks on it.
		 * By default, the photo and the Flash object are rendered in a space up to 90 pixels.
		 * The width must be an integer between 30 and 460, inclusive.
		 */
		public var expanded_width:int;
		
		/**
		 * The height of the Flash object once the user clicks on it.
		 * By default, the photo and the Flash object are rendered in a space up to 90 pixels.
		 * The height must be an integer between 30 and 460, inclusive.
		 */
		public var expanded_height:int;
		
		public function StreamFlash()
		{
			super();
			
			type = StreamMediaType.FLASH;
		}
		
		override public function toObject():Object
		{
			var object:Object = super.toObject();
			object.swfsrc = swfsrc;
			object.imgsrc = imgsrc;
			if( width > 0 ) object.width = width;
			if( height > 0 ) object.height = height;
			if( expanded_width > 0 ) object.expanded_width = expanded_width;
			if( expanded_height > 0 ) object.expanded_height = expanded_height;
			return object;
		}
		
	}
}