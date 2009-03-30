/**
 * http://wiki.developers.facebook.com/index.php/Data.dropObjectType
 * Feb 20/09
 */
package com.facebook.commands.data {
	
	import com.facebook.data.InternalErrorMessages;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.ValidationUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The DropObjectType class represents the public  
      Facebook API known as Data.dropObjectType.
	 * @see http://wiki.developers.facebook.com/index.php/Data.dropObjectType
	 */
	public class DropObjectType extends FacebookCall {

		
		public static var METHOD_NAME:String = 'data.dropObjectType';
		public static var SCHEMA:Array = ['obj_type'];
		
		public var obj_type:String;
		
		public function DropObjectType(obj_type:String) {
			super(METHOD_NAME);
			
			if (obj_type.length > 32 || ValidationUtils.isDataObjectTypeValid(obj_type) == false) {
				throw new RangeError(InternalErrorMessages.DATA_INVALID_NAME_ERROR);
			}
			
			this.obj_type = obj_type;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type);
			super.facebook_internal::initialize();
		}		
	}
}