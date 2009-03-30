/**
 * http://wiki.developers.facebook.com/index.php/Data.getAssociationDefinitions
 * FEB 23/09
 */
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;

	/**
	 * The GetAssociationDefinitions class represents the public  
      Facebook API known as Data.getAssociationDefinitions.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getAssociationDefinitions
	 */
	public class GetAssociationDefinitions extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getAssociationDefinitions';
		public static const SCHEMA:Array = [];
		
		public function GetAssociationDefinitions(){
			super(METHOD_NAME);
		}
		
	}
}