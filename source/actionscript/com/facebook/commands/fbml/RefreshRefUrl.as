/**
 * http://wiki.developers.facebook.com/index.php/Fbml.refreshRefUrl
 * FEB 23/09
 */
package com.facebook.commands.fbml {

	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The RefreshRefUrl class represents the public  
      Facebook API known as Fbml.refreshRefUrl.
	 * @see http://wiki.developers.facebook.com/index.php/Fbml.refreshRefUrl
	 */
	public class RefreshRefUrl extends FacebookCall {

		
		public static const METHOD_NAME:String = 'fbml.refreshRefUrl'
		public static const SCHEMA:Array = ['url'];
		
		public var url:String;
		
		public function RefreshRefUrl(url:String) {
			super(METHOD_NAME);
			
			this.url = url;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, url);
			super.facebook_internal::initialize();
		}
	}
}