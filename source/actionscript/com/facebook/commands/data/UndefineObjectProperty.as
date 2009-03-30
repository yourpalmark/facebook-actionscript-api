/**
 * http://wiki.developers.facebook.com/index.php/Data.undefineObjectProperty
 * Feb 20/09
 * ** (from (facebook.com) Note: Support for this method is temporarily disabled until we support user-level permissions. You can still make this call, but you must include your application secret.
 */
package com.facebook.commands.data {
	
	import com.facebook.data.InternalErrorMessages;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.utils.ValidationUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The UndefineObjectProperty class represents the public  
      Facebook API known as Data.undefineObjectProperty.
	 * @see http://wiki.developers.facebook.com/index.php/Data.undefineObjectProperty
	 */
	public class UndefineObjectProperty extends FacebookCall {

		
		public static var METHOD_NAME:String = 'data.undefineObjectProperty';
		public static var SCHEMA:Array = ['obj_type', 'prop_name'];
		
		public var obj_type:String;
		public var prop_name:String;
		
		public function UndefineObjectProperty(obj_type:String, prop_name:String) {
			super(METHOD_NAME);
			
			if (ValidationUtils.isDataObjectTypeValid(obj_type) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:obj_type}));
			}
			
			if (ValidationUtils.isDataObjectTypeValid(prop_name) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:prop_name}));
			}
			
			this.obj_type = obj_type;
			this.prop_name = prop_name;
		}	
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type, prop_name);
			super.facebook_internal::initialize();
		}
	}
}