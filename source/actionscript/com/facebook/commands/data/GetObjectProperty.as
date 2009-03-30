/**
 * http://wiki.developers.facebook.com/index.php/Data.getObjectProperty
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetObjectProperty class represents the public  
      Facebook API known as Data.getObjectProperty.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getObjectProperty
	 */
	public class GetObjectProperty extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getObjectProperty';
		public static const SCHEMA:Array = ['obj_id','prop_name'];
		
		public var obj_id:String;
		public var prop_name:String;
		
		public function GetObjectProperty(obj_id:String, prop_name:String) {
			super(METHOD_NAME);
			
			this.obj_id = obj_id;
			this.prop_name = prop_name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_id, prop_name);
			super.facebook_internal::initialize();
		}
	}
}