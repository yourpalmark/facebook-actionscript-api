/*
Copyright (c) 2007 Jason Crist

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

package com.pbking.facebook.methodGroups
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.feed.PublishActionOfUser_delegate;
	import com.pbking.facebook.delegates.feed.PublishStoryToUser_delegate;
	import com.pbking.facebook.delegates.feed.PublishTemplatizedAction_delegate;
	
	public class Feed
	{
		// VARIABLES //////////
		
		// CONSTRUCTION //////////
		
		function Feed():void
		{
			//nothing here
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		/**
		 * Publishes a News Feed story to the user corresponding to the session_key parameter.
		 * 
		 * Publishing to News Feed requires you to understand the rules of its operation.
	     * The title is required, and is limited to 60 displayed characters (excluding tags).
     	      o The <a> tag is allowed, and there can only be zero or one instance of it in the title.
         	  o No other tags are allowed. 
    	 * The body is optional, is limited to 200 displayed characters (excluding tags), and can include the tags <a>, <b>, and <i>.
    	 * Up to 4 images can be displayed, which are shrunk to fit within 75x75 pixels, cached, and formatted by Facebook. Images can either be a URL, or a facebook PID. If it is a URL, you must own the image and grant Facebook the permission to cache it. Each image must have a link associated with it, which must start with http://
    	 * Applications are limited to calling this function once every 12 hours for each user.
    	 * The story may or may not show up in the user's News Feed, depending on the number and quality of competing stories.
    	 * Developer Note: If an application developer calls feed.publishStoryToUser for his own user ID, the story is always published. This allows for testing and display tweaks. 
		 */
		public function publishStoryToUser( titleMarkup:String, bodyMarkup:String="", 
											image_1:String="", image_1_link:String="",
											image_2:String="", image_2_link:String="",
											image_3:String="", image_3_link:String="",
											image_4:String="", image_4_link:String="",
											priority:String="", callback:Function=null):PublishStoryToUser_delegate
		{
			var d:PublishStoryToUser_delegate = new PublishStoryToUser_delegate(titleMarkup, bodyMarkup,
																				image_1, image_1_link, image_2, image_2_link,
																				image_3, image_3_link, image_4, image_4_link, priority);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

		/**
		 * Publishes a Mini-Feed story to the user corresponding to the session_key parameter, and publishes News Feed stories to the friends of that user.
		 * 
		 * Publishing to Feeds requires you to understand the rules of their operation.
	     * The title is required, and is limited to 60 displayed characters (excluding tags).
     	      o One <a> tag is allowed.
       	      o One fb:userlink tag is allowed, and the uid parameter must be populated with the user ID on whose behalf the action is being published. If there is no such fb:userlink tag found, then one is automatically prepended to the title.
	          o The fb:name tag is allowed, and there may be multiple instances of this tag.
          	  o No other tags are allowed. 
    	 * The body is optional, is limited to 200 display characters (excluding tags), and can include the tags fb:userlink, fb:name, <a>, <b>, and <i>.
    	 * Up to 4 images can be displayed, which will be shrunk to fit within 75x75, cached, and formatted by Facebook. Images can either be a URL, or a facebook PID. (RobRoy: PID doesn't work for me, anyone else verify?) If it is a URL, you must own the image and grant Facebook the permission to cache it. Each image must have a link associated with it, which must start with http://
    	 * Applications are limited to calling this function 10 times for each user in a rolling 48-hour window.
    	 * The story may or may not show up in the user's friends' News Feeds, depending on the number and quality of competing stories.
    	 * Developer Note: Since this method affects all Facebook friends of the developer, testing this method does abide by the limited-calling rule (unlike feed.publishStoryToUser). 
		 */
		public function publishActionOfUser(titleMarkup:String, bodyMarkup:String="", 
											image_1:String="", image_1_link:String="",
											image_2:String="", image_2_link:String="",
											image_3:String="", image_3_link:String="",
											image_4:String="", image_4_link:String="",
											callback:Function=null):PublishActionOfUser_delegate
		{
			var d:PublishActionOfUser_delegate = new PublishActionOfUser_delegate(titleMarkup, bodyMarkup,
																				image_1, image_1_link, image_2, image_2_link,
																				image_3, image_3_link, image_4, image_4_link);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

		/**
		 * Publishes a Mini-Feed story to the user or Page corresponding to the actor_id parameter. 
		 * For user stories, this function publishes News Feed stories to the friends of that user.
		 * See http://wiki.developers.facebook.com/index.php/Feed.publishTemplatizedAction for more info.
		 */
		public function publishTemplatizedAction(actor:FacebookUser, title_template:String="", title_data:String="", 
													body_template:String="", body_data:String="", body_general:String="", 
													targetUsers:Array = null,
													image_1:String="", image_1_link:String="",
													image_2:String="", image_2_link:String="",
													image_3:String="", image_3_link:String="",
													image_4:String="", image_4_link:String="",
													callback:Function=null):PublishTemplatizedAction_delegate
		{
			var d:PublishTemplatizedAction_delegate = new PublishTemplatizedAction_delegate(actor, title_template, title_data,
																							body_template, body_data, body_general, targetUsers,
																							image_1, image_1_link, image_2, image_2_link,
																							image_3, image_3_link, image_4, image_4_link);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}
	}
}