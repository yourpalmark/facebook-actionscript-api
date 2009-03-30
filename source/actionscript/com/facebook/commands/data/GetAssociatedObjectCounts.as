/**
 * http://wiki.developers.facebook.com/index.php/Data.getAssociatedObjectCounts
 * FEB 23/ 09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetAssociatedObjectCounts class represents the public  
      Facebook API known as Data.getAssociatedObjectCounts.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getAssociatedObjectCounts
	 */
	public class GetAssociatedObjectCounts extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getAssociatedObjectCounts';
		public static const SCHEMA:Array = ['name', 'obj_ids'];
		
		public var name:String;
		public var obj_ids:Array;
		
		public function GetAssociatedObjectCounts(name:String ,obj_ids:Array) {
			super(METHOD_NAME);
			
			this.name = name;
			this.obj_ids = obj_ids;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, obj_ids);
			super.facebook_internal::initialize();
		}
	}
}