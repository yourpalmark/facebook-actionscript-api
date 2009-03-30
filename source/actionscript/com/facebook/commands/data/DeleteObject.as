/**
 * http://wiki.developers.facebook.com/index.php/Data.deleteObject
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;
	
	use namespace facebook_internal;

	/**
	 * The DeleteObject class represents the public  
      Facebook API known as Data.deleteObject.
	 * @see http://wiki.developers.facebook.com/index.php/Data.deleteObject
	 */
	public class DeleteObject extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.deleteObject';
		public static const SCHEMA:Array = ['obj_id'];
		
		public var obj_id:String;
		
		public function DeleteObject(obj_id:String) {
			super(METHOD_NAME);
			
			this.obj_id = obj_id;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_id);
			super.facebook_internal::initialize();
		}
	}
}