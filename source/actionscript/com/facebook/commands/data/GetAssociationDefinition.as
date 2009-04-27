/**
 * http://wiki.developers.facebook.com/index.php/Data.getAssociationDefinition
 * FEB 23/09
 */
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The GetAssociationDefinition class represents the public  
      Facebook API known as Data.getAssociationDefinition.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getAssociationDefinition
	 */
	public class GetAssociationDefinition extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getAssociationDefinition';
		public static const SCHEMA:Array = ['name'];
		
		public var name:String;
		
		public function GetAssociationDefinition(name:String) {
			super(METHOD_NAME);
			
			this.name = name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name);
			super.facebook_internal::initialize();
		}
	}
}