package com.facebook.graph.data.ui.stream
{
	public class StreamMP3 extends StreamMedia
	{
		/**
		 * The URL of the MP3 file to be rendered within Facebook's MP3 player plugin.
		 */
		public var src:String;
		
		/**
		 * The title of the MP3.
		 */
		public var title:String;
		
		/**
		 * The artist of the MP3.
		 */
		public var artist:String;
		
		/**
		 * The album of the MP3.
		 */
		public var album:String;
		
		public function StreamMP3()
		{
			super();
			
			type = StreamMediaType.MP3;
		}
		
		override public function toObject():Object
		{
			var object:Object = super.toObject();
			object.src = src;
			if( title ) object.title = title;
			if( artist ) object.artist = artist;
			if( album ) object.album = album;
			return object;
		}
		
	}
}