/**
 * http://wiki.developers.facebook.com/index.php/Feed.getRegisterTemplateBundles
 * Feb 20/09
 */ 
package com.facebook.commands.feed {
	
	import com.facebook.net.FacebookCall;

	/**
	 * The GetRegisteredTemplateBundles class represents the public  
      Facebook API known as Feed.getRegisteredTemplateBundles.
	 * @see http://wiki.developers.facebook.com/index.php/Feed.getRegisteredTemplateBundles
	 */
	public class GetRegisteredTemplateBundles extends FacebookCall {

		
		public static const METHOD_NAME:String = 'feed.getRegisteredTemplateBundles';
		public static const SCHEMA:Array = [];
		
		public function GetRegisteredTemplateBundles() {
			super(METHOD_NAME);
		}
		
	}
}