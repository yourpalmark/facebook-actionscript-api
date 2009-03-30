/**
 * http://wiki.developers.facebook.com/index.php/Data.setUserPreference
 * Feb 19/09
 */
package com.facebook.commands.data {
	
	import com.facebook.data.InternalErrorMessages;
	import com.facebook.net.FacebookCall;
	
	/**
	 * The GetUserPreferences class represents the public  
      Facebook API known as Data.getUserPreferences.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getUserPreferences
	 */
	public class GetUserPreferences extends FacebookCall {

		
		public static var METHOD_NAME:String = 'data.getUserPreferences';
		public static var SCHEMA:Array = [];
		
		public function GetUserPreferences() {
			super(METHOD_NAME);
		}		
	}
}