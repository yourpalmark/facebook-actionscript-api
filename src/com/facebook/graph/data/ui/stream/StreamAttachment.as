package com.facebook.graph.data.ui.stream
{
	import flash.utils.Dictionary;
	
	public class StreamAttachment
	{
		/**
		 * The title of the post.
		 * The post should fit on one line in a user's stream;
		 * make sure you account for the width of any thumbnail.
		 */
		public var name:String;
		
		/**
		 * The URL to the source of the post referenced in the name.
		 * The URL should not be longer than 1024 characters.
		 */
		public var href:String;
		
		/**
		 * A subtitle for the post that should describe why the user posted the item or the action the user took.
		 * This field can contain plain text only, as well as the {actor} token, which gets replaced by a link to the profile of the session user.
		 * The caption should fit on one line in a user's stream;
		 * make sure you account for the width of any thumbnail.
		 */
		public var caption:String;
		
		/**
		 * Descriptive text about the story.
		 * This field can contain plain text only and should be no longer than is necessary for a reader to understand the story.
		 * The description can contain up to 1,000 characters, but Facebook displays the first 300 or so characters of text by default;
		 * users can see the remaining text by clicking a "See More" link that we append automatically to long stories, or attachments with more than one image.
		 */
		public var description:String;
		
		/**
		 * A dictionary of key/value pairs that provide more information about the post.
		 * The key should be the label of the property (e.g., "Length").
		 * The value can either be a string or an array.
		 * If it's a string, it will be rendered as the value (e.g., if the value is "0:17", then the full property will be rendered as "Length: 0:17").
		 * If it's an array, the array can contain two properties -- "text" and "href".
		 * The text key will point to the value (again, "0:17").
		 * The href key will point to a link which will hyperlink the value.
		 * The key can have a maximum length of 50 characters.
		 * The value can have a maximum length of 70 characters.
		 */
		public var properties:Dictionary;
		
		/**
		 * Rich media that provides visual content for the post.
		 * media is an array that contains one of the following types: image, flash, or mp3.
		 * Make sure you specify only one of these types in your post.
		 */
		public var media:Array; //Array of StreamMedia
		
		/**
		 * An application-specific xid associated with the stream post.
		 * The xid allows you to get comments made to this post using the comments.get.
		 * It also allows you to associate comments made to this post with a Comments Box for FBML fb:comments.
		 */
		public var comments_xid:String;
		
		/**
		 * You can include your own key/value pairs for your own use later on.
		 * These key/value pairs won't appear in any user's stream when published, but Facebook stores them.
		 * When you retrieve the user's stream later with stream.get, these key/value pairs get returned with the rest of the user's stream.
		 */
		public var keyValuePairs:Dictionary;
		
		public function StreamAttachment()
		{
		}
		
		public function toObject():Object
		{
			var object:Object = {};
			if( name ) object.name = name;
			if( href ) object.href = href;
			if( caption ) object.caption = caption;
			if( description ) object.description = description;
			if( properties )
			{
				object.properties = {};
				for( var prop:String in properties )
				{
					object.properties[ prop ] = properties[ prop ];
				}
			}
			if( media && media.length > 0 )
			{
				object.media = [];
				for each( var streamMedia:StreamMedia in media )
				{
					object.media.push( streamMedia.toObject() );
				}
			}
			if( comments_xid ) object.comments_xid = comments_xid;
			if( keyValuePairs )
			{
				for( var key:String in keyValuePairs )
				{
					object[ key ] = keyValuePairs[ key ];
				}
			}
			return object;
		}
		
	}
}