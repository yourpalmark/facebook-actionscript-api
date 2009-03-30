/**
 * http://wiki.developers.facebook.com/index.php/Data.getObjectTypes
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;

	/**
	 * The GetObjectTypes class represents the public  
      Facebook API known as Data.getObjectTypes.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getObjectTypes
	 */
	public class GetObjectTypes extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getObjectTypes';
		public static const SCHEMA:Array = [];
		
		public function GetObjectTypes() {
			super(METHOD_NAME);
		}
	}
}