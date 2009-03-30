/**
 * http://wiki.developers.facebook.com/index.php/Fbml.getCustomTags
 * FEB 23/09

 */ 
package com.facebook.commands.fbml {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetCustomTags class represents the public  
      Facebook API known as Fbml.getCustomTags.
	 * @see http://wiki.developers.facebook.com/index.php/Fbml.getCustomTags
	 */
	public class GetCustomTags extends FacebookCall	{

		
		public static const METHOD_NAME:String = 'fbml.getCustomTags';
		public static const SCHEMA:Array = ['app_id'];
		
		protected var app_id:String;
		
		public function GetCustomTags(app_id:String='') {
			super(METHOD_NAME);
			
			this.app_id = app_id;
		}
		
		override facebook_internal function initialize():void {
			this.applySchema(SCHEMA, this.app_id);
			super.facebook_internal::initialize();
		}
	}
}