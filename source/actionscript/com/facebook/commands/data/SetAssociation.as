/**
 * http://wiki.developers.facebook.com/index.php/Data.setAssociation
 * FEB 23/09
 */ 
package com.facebook.commands.data {

	import com.facebook.data.InternalErrorMessages;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.utils.ValidationUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The SetAssociation class represents the public  
      Facebook API known as Data.setAssociation.
	 * @see http://wiki.developers.facebook.com/index.php/Data.setAssociation
	 */
	public class SetAssociation extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.setAssociation';
		public static const SCHEMA:Array = ['name', 'obj_id1', 'obj_id2', 'data', 'assoc_time'];
		
		public var name:String;
		public var obj_id1:String;
		public var obj_id2:String;
		public var data:String;
		public var assoc_time:Date;
		
		public function SetAssociation(name:String, obj_id1:String, obj_id2:String,data:String = null, assoc_time:Date = null) {
			super(method, args);
			
			if (ValidationUtils.validateLength(data) == false) {
				throw new RangeError(FacebookDataUtils.supplantString(InternalErrorMessages.DATA_INVALID_NAME_ERROR, {propName:data}));
			}
			
			this.name = name;
			this.obj_id1 = obj_id1;
			this.obj_id2 = obj_id2;
			this.assoc_time = assoc_time;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, obj_id1, obj_id2, data, FacebookDataUtils.toDateString(assoc_time));
			super.facebook_internal::initialize();
		}
	}
}