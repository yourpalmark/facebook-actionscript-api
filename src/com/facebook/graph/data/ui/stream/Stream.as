package com.facebook.graph.data.ui.stream
{
	public class Stream
	{
		/**
		 * The message the user enters for the post at the time of publication.
		 * If the message is a status update (that is, you're not including an attachment or an action link), it can contain up to 420 characters.
		 * Otherwise, if the post contains an attachment or action link, the message can contain up to 10,000 characters.
		 */
		public var message:String;
		
		/**
		 * A JSON-encoded object containing the text of the post, relevant links, a media type (image, mp3, flash), as well as any other key/value pairs you may want to add.
		 * Note: If you want to use this call to update a user's status, don't pass this parameter.
		 * See Updating a User's Status above.
		 */
		public var attachment:StreamAttachment;
		
		/**
		 * A JSON-encoded array of action link objects, containing the link text and a hyperlink.
		 * If you want to use this call to update a user's status, don't pass this parameter.
		 * See Updating a User's Status above.
		 */
		public var action_links:Array; //Array of StreamActionLink
		
		/**
		 * The ID of the user, Page, group, or event where you are publishing the content.
		 * If you specify a target_id, the post appears on the Wall of the target profile, Page, group, or event, not on the Wall of the user who published the post.
		 * This mimics the action of posting on a friend's Wall on Facebook itself.
		 * Note: If you specify a Page ID as the uid, you cannot specify a target_id.
		 * Pages cannot write on other users' Walls.
		 * Note: You cannot publish to an application profile page's Wall.
		 */
		public var target_id:String;
		
		/**
		 * The ID of the user or Page publishing the post.
		 * If this parameter is not specified, then it defaults to the session user.
		 * If you want to publish as page, you should use the 'enable_profile_selector' option with FB.login.
		 * This option enables the profile selector on the permission dialog.
		 * Note: If you specify a Page ID as the uid, you cannot specify a target_id. Pages cannot write on other users' Walls.
		 */
		public var uid:String;
		
		/**
		 * An object that defines the privacy setting for a post, video, or album.
		 * Only the user can specify the privacy settings for the post.
		 */
		public var privacy:StreamPrivacy;
		
		public function Stream()
		{
		}
		
		public function toObject():Object
		{
			var object:Object = {};
			if( message ) object.message = message;
			if( attachment ) object.attachment = attachment.toObject();
			if( action_links && action_links.length > 0 )
			{
				object.action_links = [];
				for each( var streamActionLink:StreamActionLink in action_links )
				{
					object.action_links.push( streamActionLink.toObject() );
				}
			}
			if( target_id ) object.target_id = target_id;
			if( uid ) object.uid = uid;
			if( privacy ) object.privacy = privacy.toObject();
			return object;
		}
		
	}
}