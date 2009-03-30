/**
 * http://wiki.developers.facebook.com/index.php/Data.defineAssociation
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.data.InternalErrorMessages;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.utils.ValidationUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The RenameAssociation class represents the public  
      Facebook API known as Data.renameAssociation.
	 * @see http://wiki.developers.facebook.com/index.php/Data.renameAssociation
	 */
	public class RenameAssociation extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.renameAssociation';
		public static const SCHEMA:Array = ['name','new_name','new_alias1','new_alias2'];
		
		public var name:String;
		public var new_name:String;
		public var new_alias1:String;
		public var new_alias2:String;
		
		public function RenameAssociation(name:String, new_name:String='', new_alias1:String='', new_alias2:String='') {
			super(METHOD_NAME);
			
			if (ValidationUtils.isDataObjectTypeValid(new_name) == false ) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:new_name}));
			}
			if (ValidationUtils.isDataObjectTypeValid(new_alias1) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:new_alias1}));
			}
			if (ValidationUtils.isDataObjectTypeValid(new_alias2) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:new_alias2}));
			}
			
			this.name = name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, new_name, new_alias1, new_alias2); 
			super.facebook_internal::initialize();
		}
	}
}