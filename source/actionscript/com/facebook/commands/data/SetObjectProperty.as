/**
 *http://wiki.developers.facebook.com/index.php/Data.setObjectProperty
 *FEB 24.09
 */  
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The SetObjectProperty class represents the public  
      Facebook API known as Data.setObjectProperty.
	 * @see http://wiki.developers.facebook.com/index.php/Data.setObjectProperty
	 */
	public class SetObjectProperty extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.setObjectProperty';
		public static const SCHEMA:Array = ['obj_id','prop_name','prop_value'];
		
		public var obj_id:String;
		public var prop_name:String;
		public var prop_value:String;
		
		public function SetObjectProperty(obj_id:String, prop_name:String, prop_value:String) {
			super(METHOD_NAME);
			
			this.obj_id = obj_id;
			this.prop_name = prop_name;
			this.prop_value = prop_value;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_id, prop_name, prop_value);
			super.facebook_internal::initialize();
		}
	}
}