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
	 * The SetUserPreference class represents the public  
      Facebook API known as Data.setUserPreference.
	 * @see http://wiki.developers.facebook.com/index.php/Data.setUserPreference
	 */
	public class SetUserPreference extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.setUserPreference';
		public static const SCHEMA:Array = ['pref_id', 'value'];
		
		public var pref_id:Number;
		public var value:String;
		
		public function SetUserPreference(pref_id:uint, value:String) {
			super(METHOD_NAME);
			
			if (pref_id > 200) {
				throw new RangeError(InternalErrorMessages.USER_PREFERENCE_ID_RANGE_ERROR);
			}
			
			if (value != null && value.length > 128) {
				throw new RangeError(InternalErrorMessages.USER_PREFERENCE_VALUE_RANGE_ERROR);
			}
			
			if (value == null) { value = '0'; }
			
			this.pref_id = pref_id;
			this.value = value;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, pref_id, value);
			super.facebook_internal::initialize();
		}		
	}
}