/**
 *http://wiki.developers.facebook.com/index.php/Data.getAssociatedObjects 
 * FEB 23 /09
 */
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetAssociatedObjects class represents the public  
      Facebook API known as Data.getAssociatedObjects.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getAssociatedObjects
	 */
	public class GetAssociatedObjects extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getAssociatedObjects';
		public static const SCHEMA:Array = ['name','obj_id','no_data'];
		
		public var name:String;
		public var obj_id:String;
		public var no_data:Boolean;
	
		public function GetAssociatedObjects(name:String, obj_id:String, no_data:Boolean=false) {
			super(METHOD_NAME);
			
			this.name = name;
			this.obj_id = obj_id;
			this.no_data = no_data;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, obj_id, no_data);
			super.facebook_internal::initialize();
		}
	}
}