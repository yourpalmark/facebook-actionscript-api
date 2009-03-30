/**
 * http://wiki.developers.facebook.com/index.php/Data.deleteObjects
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import flash.net.URLVariables;
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The DeleteObjects class represents the public  
      Facebook API known as Data.deleteObjects.
	 * @see http://wiki.developers.facebook.com/index.php/Data.deleteObjects
	 */
	public class DeleteObjects extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.deleteObjects';
		public static const SCHEMA:Array = ['obj_ids'];
		
		public var obj_ids:Array;
		
		public function DeleteObjects(obj_ids:Array) {
			super(METHOD_NAME);
			
			this.obj_ids = obj_ids;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_ids);
			super.facebook_internal::initialize();
		}
	}
}