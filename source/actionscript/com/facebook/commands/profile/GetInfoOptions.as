package com.facebook.commands.profile {

	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetInfoOptions class represents the public  
      Facebook API known as Profile.getInfoOptions.
	 * @see http://wiki.developers.facebook.com/index.php/Profile.getInfoOptions
	 */
	public class GetInfoOptions extends FacebookCall {

		
		public static const METHOD_NAME:String = 'profile.getInfoOptions';
		public static const SCHEMA:Array = ['field'];
		
		public var field:String;
	
		public function GetInfoOptions(field:String){
			super(METHOD_NAME);
			
			this.field = field;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, field);
			super.facebook_internal::initialize();
		}
	}
}