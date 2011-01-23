package com.facebook.graph.data.api.post
{
	import com.adobe.utils.DateUtil;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	/**
	 * An individual entry in a profile's feed.
	 * @see http://developers.facebook.com/docs/reference/api/post
	 */
	public class FacebookPost
	{
		/**
		 * The post ID.
		 */
		public var id:String;
		
		/**
		 * An object containing the ID and name of the user who posted the message.
		 */
		public var from:FacebookUser;
		
		/**
		 * A list of the profiles mentioned or targeted in this post.
		 */
		public var to:Object;
		
		/**
		 * The message.
		 */
		public var message:String;
		
		/**
		 * If available, a link to the picture included with this post.
		 */
		public var picture:String;
		
		/**
		 * The link attached to this post.
		 */
		public var link:String;
		
		/**
		 * The name of the link.
		 */
		public var name:String;
		
		/**
		 * The caption of the link (appears beneath the link name).
		 */
		public var caption:String;
		
		/**
		 * A description of the link (appears beneath the link caption).
		 */
		public var description:String;
		
		/**
		 * The type of the link (status, photo, video or link) appears as part of a news feed connection.
		 */
		public var type:String;
		
		/**
		 * If available, the source link attached to this post (for example, a flash or video file).
		 */
		public var source:String;
		
		/**
		 * A link to an icon representing the type of this post.
		 */
		public var icon:String;
		
		/**
		 * A string indicating which application was used to create this post.
		 */
		public var attribution:String;
		
		/**
		 * A list of available actions on the post (including commenting, liking, and an optional app-specified action), encoded as objects with keys for the 'name' and 'link'.
		 */
		public var actions:Array;
		
		/**
		 * An object that defines the privacy setting for a post, video, or album.
		 * Only the user can specify the privacy settings for the post.
		 */
		public var privacy:FacebookPostPrivacy;
		
		/**
		 * The number of likes on this post.
		 */
		public var likes:int;
		
		/**
		 * The time the post was initially published.
		 */
		public var created_time:Date;
		
		/**
		 * The time of the last comment on this post.
		 */
		public var updated_time:Date;
		
		/**
		 * Creates a new FacebookPost.
		 */
		public function FacebookPost()
		{
		}
		
		/**
		 * Populates the post from a decoded JSON object.
		 */
		public function fromJSON( result:Object ):void
		{
			if( result != null )
			{
				for( var property:String in result )
				{
					switch( property )
					{
						case "from":
							from = new FacebookUser();
							from.fromJSON( result[ property ] );
							break;
						
						case "privacy":
							privacy = new FacebookPostPrivacy();
							privacy.fromJSON( result[ property ] );
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
		 * Provides the string value of the post.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', name: ' + name + ' ]';
		}
		
	}
}