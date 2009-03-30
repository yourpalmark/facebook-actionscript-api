/**
 * http://wiki.developers.facebook.com/index.php/Data.defineAssociation
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.data.InternalErrorMessages;
	import com.facebook.data.data.AssocInfoData;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.utils.ValidationUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The DefineAssociation class represents the public  
      Facebook API known as Data.defineAssociation.
	 * @see http://wiki.developers.facebook.com/index.php/Data.defineAssociation
	 */
	public class DefineAssociation extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.defineAssociation';
		public static const SCHEMA:Array = ['name', 'assoc_type', 'assoc_info1', 'assoc_info2', 'inverse'];
		
		protected var name:String;
		protected var assoc_type:Number;
		protected var assoc_info1:AssocInfoData;
		protected var assoc_info2:AssocInfoData;
		protected var inverse:String;
		
		public function DefineAssociation(name:String, assoc_type:Number, assoc_info1:AssocInfoData, assoc_info2:AssocInfoData, inverse:String) {
			super(METHOD_NAME);
			
			if (ValidationUtils.isDataObjectTypeValid(name) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:name}));
			}
			if(ValidationUtils.isDataObjectTypeValid(inverse) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:inverse}));
			}
			
			this.name = name;
			this.assoc_type = assoc_type;
			this.assoc_info1 = assoc_info1;
			this.assoc_info2 = assoc_info2;
			this.inverse = inverse;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, assoc_type, assoc_info1, assoc_info2,inverse);
			super.facebook_internal::initialize();
		}
	}
}