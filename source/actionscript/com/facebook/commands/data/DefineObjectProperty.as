/**
 * http://wiki.developers.facebook.com/index.php/Data.defineObjectProperty
 * Feb 20/09
 */
package com.facebook.commands.data {
	
	import com.facebook.data.InternalErrorMessages;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.utils.ValidationUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The DefineObjectProperty class represents the public  
      Facebook API known as Data.defineObjectProperty.
	 * @see http://wiki.developers.facebook.com/index.php/Data.defineObjectProperty
	 */
	public class DefineObjectProperty extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.defineObjectProperty';
		public static const SCHEMA:Array = ['obj_type', 'prop_name', 'prop_type'];
		
		public var obj_type:String;
		public var prop_name:String;
		
		/**
		 * @see com.facebook.data.data.DataPropTypeValues
		 * 
		 */
		public var prop_type:uint;
		
		public function DefineObjectProperty(obj_type:String, prop_name:String, prop_type:uint) {
			super(METHOD_NAME);
			
			if (ValidationUtils.isDataObjectTypeValid(obj_type) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:obj_type}));
			}
			
			if (ValidationUtils.isDataObjectTypeValid(prop_name) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:prop_name}));
			}
			
			this.prop_name = prop_name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type, prop_name, prop_type);
			super.facebook_internal::initialize();
		}		
	}
}