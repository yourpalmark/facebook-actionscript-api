package com.facebook.graph.data.api.video
{
	import com.adobe.utils.DateUtil;
	
	/**
	 * An individual video.
	 * @see http://developers.facebook.com/docs/reference/api/video
	 */
	public class FacebookVideo
	{
		/**
		 * The video ID.
		 */
		public var id:String;
		
		/**
		 * An object containing the name and ID of the entity who posted the video.
		 * This may be a user or a Page.
		 */
		public var from:Object;
		
		/**
		 * An array of users who are tagged in this video.
		 * Each user object contains their ID and name.
		 */
		public var tags:Array; //Array of FacebookVideoTag
		
		/**
		 * The video title / caption.
		 */
		public var name:String;
		
		/**
		 * The URL of a still image which represents the content of the video.
		 */
		public var picture:String;
		
		/**
		 * An HTML string which can be embedded in an HTML page which will render a playable version of the video in Facebook's flash player.
		 */
		public var embed_html:String;
		
		/**
		 * The URL of the icon that Facebook displays when video are published to the Feed.
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
		 * Populates the video from a decoded JSON object.
		 */
		public function fromJSON( result:Object ):void
		{
			if( result != null )
			{
				for( var property:String in result )
				{
					switch( property )
					{
						case "tags":
							tags = [];
							if( result[ property ].hasOwnProperty( "data" ) )
							{
								var tagsData:Array = result[ property ].data;
								for each( var tagData:Object in tagsData )
								{
									var tag:FacebookVideoTag = new FacebookVideoTag();
									tag.fromJSON( tagData );
									tags.push( tag );
								}
							}
							break;
						
						case "created_time":
							created_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						case "updated_time":
							updated_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						default:
							if( hasOwnProperty( property ) ) this[ property ] = result[ property ];
							break;
					}
				}
			}
		}
		
		/**
		 * Provides the string value of the video.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}