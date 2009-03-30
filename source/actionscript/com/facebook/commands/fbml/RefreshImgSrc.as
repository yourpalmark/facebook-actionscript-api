/**
 * http://wiki.developers.facebook.com/index.php/Fbml.refreshImgSrc
 * FEB 23/09
 */ 
package com.facebook.commands.fbml {

	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The RefreshImgSrc class represents the public  
      Facebook API known as Fbml.refreshImgSrc.
	 * @see http://wiki.developers.facebook.com/index.php/Fbml.refreshImgSrc
	 */
	public class RefreshImgSrc extends FacebookCall {

		
		public static const METHOD_NAME:String = 'fbml.refreshImgSrc';
		public static const SCHEMA:Array = ['url'];
		
		public var url:String;
				
		public function RefreshImgSrc(url:String) {
			super(METHOD_NAME);
			
			this.url = url;
		}
		
		override facebook_internal function initialize():void {
			this.applySchema(SCHEMA, url);
			super.facebook_internal::initialize();
		}
	}
}