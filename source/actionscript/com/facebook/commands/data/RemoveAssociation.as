/**
 * http://wiki.developers.facebook.com/index.php/Data.removeAssociation
 * FEB 23/09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The RemoveAssociation class represents the public  
      Facebook API known as Data.removeAssociatedObjects.
	 * @see http://wiki.developers.facebook.com/index.php/Data.removeAssociatedObjects
	 */
	public class RemoveAssociation extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.removeAssociatedObjects';
		public static const SCHEMA:Array = ['name','obj_id1','obj_id2'];
		
		public var name:String;
		public var obj_id1:Number;
		public var obj_id2:Number;
		
		public function RemoveAssociation() {
			super(METHOD_NAME);
			
			this.name = name;
			this.obj_id1 = obj_id1;
			this.obj_id2 = obj_id2;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, obj_id1, obj_id2);
			super.facebook_internal::initialize();
		}
	}
}