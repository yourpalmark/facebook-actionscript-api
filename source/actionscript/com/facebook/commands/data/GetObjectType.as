/**
 * http://wiki.developers.facebook.com/index.php/Data.getObjectType
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetObjectType class represents the public  
      Facebook API known as Data.getObjectType.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getObjectType
	 */
	public class GetObjectType extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getObjectType';
		public static const SCHEMA:Array = ['obj_type'];
		
		public var obj_type:String;
		
		public function GetObjectType(obj_type:String) {
			super(METHOD_NAME);
			
			this.obj_type = obj_type;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type);
			super.facebook_internal::initialize();
		}
	}
}