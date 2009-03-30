/**
 * http://wiki.developers.facebook.com/index.php/Data.removeAssociations
 * FEB 23/09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The RemoveAssociations class represents the public  
      Facebook API known as Data.removeAssociations.
	 * @see http://wiki.developers.facebook.com/index.php/Data.removeAssociations
	 */
	public class RemoveAssociations extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.removeAssociations';
		public static const SCHEMA:Array = ['assocs','name'];
		
		public var assocs:Array;
		public var name:String;
		
		public function RemoveAssociations(assocs:Array, name:String='') {
			super(METHOD_NAME);
			
			this.assocs = assocs;
			this.name = name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, assocs, name);
			super.facebook_internal::initialize();
		}
	}
}