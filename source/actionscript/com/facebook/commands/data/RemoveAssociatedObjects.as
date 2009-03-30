/**
 * http://wiki.developers.facebook.com/index.php/Data.removeAssociatedObjects
 * FEB 23/09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The RemoveAssociatedObjects class represents the public  
      Facebook API known as Data.removeAssociatedObjects.
	 * @see http://wiki.developers.facebook.com/index.php/Data.removeAssociatedObjects
	 */
	public class RemoveAssociatedObjects extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.removeAssociatedObjects';
		public static const SCHEMA:Array = ['name','obj_id'];
		
		public var name:String;
		public var obj_id:String;
		
		public function RemoveAssociatedObjects(name:String, obj_id:String) {
			super(METHOD_NAME);
			
			this.name = name;
			this.obj_id = obj_id;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, obj_id);
			super.facebook_internal::initialize();
		}
	}
}