/**
 * http://wiki.developers.facebook.com/index.php/Data.createObjectType
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
	 * The CreateObjectType class represents the public  
      Facebook API known as Data.createObjectType.
	 * @see http://wiki.developers.facebook.com/index.php/Data.createObjectType
	 */
	public class CreateObjectType extends FacebookCall {

		
		public static var METHOD_NAME:String = 'data.createObjectType';
		public static var SCHEMA:Array = ['name'];
		
		public var name:String;
		
		public function CreateObjectType(name:String) {
			super(METHOD_NAME);
			
			if (ValidationUtils.isDataObjectTypeValid(name) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:name}));
			}
			
			this.name = name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, this.name);
			super.facebook_internal::initialize();
		}		
	}
}