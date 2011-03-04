package com.facebook.graph.data.api.video
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * An individual video.
	 * @see http://developers.facebook.com/docs/reference/api/video
	 */
	public class FacebookVideo extends AbstractFacebookGraphObject
	{
		/**
		 * The profile (user or page) that created the video.
		 */
		public var from:Object;
		
		/**
		 * The users who are tagged in this video.
		 */
		public var tags:Array;
		
		/**
		 * The video title or caption.
		 */
		public var name:String;
		
		/**
		 * The html element that may be embedded in a web page to play the video.
		 */
		public var embed_html:String;
		
		/**
		 * The icon that Facebook displays when the video is published to the Feed.
		 */
		public var icon:String;
		
		/**
		 * A URL to the raw, playable video file.
		 */
		public var source:String;
		
		/**
		 * The time the video was initially published.
		 */
		public var created_time:Date;
		
		/**
		 * The last time the video or its caption were updated.
		 */
		public var updated_time:Date;
		
		/**
		 * Creates a new FacebookVideo.
		 */
		public function FacebookVideo()
		{
		}
		
		/**
		 * Populates and returns a new FacebookVideo from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookVideo.
		 */
		public static function fromJSON( result:Object ):FacebookVideo
		{
			var video:FacebookVideo = new FacebookVideo();
			video.fromJSON( result );
			return video;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookVideoField.TAGS:
					tags = [];
					var tagsData:Array = value is Array ? value : Object( value ).hasOwnProperty( "data" ) && value.data is Array ? value.data : [];
					for each( var tagData:Object in tagsData )
					{
						tags.push( FacebookVideoTag.fromJSON( tagData ) );
					}
					break;
				
				default:
					super.setPropertyValue( property, value );
					break;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ FacebookVideoField.ID, FacebookVideoField.NAME ] );
		}
		
	}
}