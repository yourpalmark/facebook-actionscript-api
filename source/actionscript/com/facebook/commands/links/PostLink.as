/**
 * http://wiki.developers.facebook.com/index.php/Links.post
 */
package com.facebook.commands.links {

	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The PostLink class represents the public  
      Facebook API known as Links.post.
	 * @see http://wiki.developers.facebook.com/index.php/Links.post
	 */
	public class PostLink extends FacebookCall {


		public static var METHOD_NAME:String = 'links.post';
		public static var SCHEMA:Array = ['uid','url','comment'];

		public var uid:String;
		public var url:String;
		public var comment:String;

		public function PostLink(uid:String, url:String, comment:String) {
			super(METHOD_NAME);

			this.uid = uid;
			this.url = url;
			this.comment = comment;
		}

		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid, url, comment);
			super.facebook_internal::initialize();
		}
	}
}
