/**
 * Feb 19/09 
 * http://wiki.developers.facebook.com/index.php/Profile.setInfoOptions
 */
package com.facebook.commands.profile {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The SetInfoOptions class represents the public  
      Facebook API known as Profile.setInfoOptions.
	 * @see http://wiki.developers.facebook.com/index.php/Profile.setInfoOptions
	 */
	public class SetInfoOptions extends FacebookCall {

		
		public static var METHOD_NAME:String = 'profile.setInfoOptions';
		public static var SCHEMA:Array = ['field','options','format'];
		
		public var field:String;
		public var options:Array;
		public var format:String;
		
		public function SetInfoOptions(field:String, options:Array, format:String) {
			super(METHOD_NAME);
			
			this.field = field;
			this.options = options;
			this.format = format;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, field, options, format);
			super.facebook_internal::initialize();
		}
	}
}