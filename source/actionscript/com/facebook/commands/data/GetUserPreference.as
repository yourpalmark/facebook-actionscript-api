/**
 * http://wiki.developers.facebook.com/index.php/Data.setUserPreference
 * Feb 19/09
 */
package com.facebook.commands.data {
	
	import com.facebook.data.InternalErrorMessages;
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The GetUserPreference class represents the public  
      Facebook API known as Data.getUserPreference.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getUserPreference
	 */
	public class GetUserPreference extends FacebookCall {

		
		public static var METHOD_NAME:String = 'data.getUserPreference';
		public static var SCHEMA:Array = ['pref_id'];
		
		public var pref_id:Number;
		public var value:String;
		
		public function GetUserPreference(pref_id:uint) {
			super(METHOD_NAME);
			
			if (pref_id > 200) {
				throw new RangeError(InternalErrorMessages.USER_PREFERENCE_ID_RANGE_ERROR);
			}
			
			this.pref_id = pref_id;
		}	
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, pref_id);
			super.facebook_internal::initialize();
		}	
	}
}