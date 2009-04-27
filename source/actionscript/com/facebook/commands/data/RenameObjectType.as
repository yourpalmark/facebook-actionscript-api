/**
 * http://wiki.developers.facebook.com/index.php/Data.renameObjectType
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
	 * The RenameObjectType class represents the public  
      Facebook API known as Data.renameObjectType.
	 * @see http://wiki.developers.facebook.com/index.php/Data.renameObjectType
	 */
	public class RenameObjectType extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.renameObjectType';
		public static const SCHEMA:Array = ['obj_type', 'new_name'];
		
		public var obj_type:String;
		public var new_name:String;
		
		public function RenameObjectType(obj_type:String, new_name:String) {
			super(METHOD_NAME);
			
			if (ValidationUtils.isDataObjectTypeValid(obj_type) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:obj_type}));
			}
			
			if (ValidationUtils.isDataObjectTypeValid(new_name) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:new_name}));
			}
			
			this.obj_type = obj_type;
			this.new_name = new_name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type, new_name);
			super.facebook_internal::initialize();
		}
	}
}