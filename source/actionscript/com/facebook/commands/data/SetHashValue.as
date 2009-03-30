/**
 * http://wiki.developers.facebook.com/index.php/Data.setHashValue
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The SetHashValue class represents the public  
      Facebook API known as Data.setHashValue.
	 * @see http://wiki.developers.facebook.com/index.php/Data.setHashValue
	 */
	public class SetHashValue extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.setHashValue';
		public static const SCHEMA:Array = ['obj_type','key','value','prop_name'];
		
		public var obj_type:String;
		public var key:String;
		public var value:String;
		public var prop_name:String;
		
		public function SetHashValue(obj_type:String, key:String, value:String, prop_name:String) {
			super(METHOD_NAME);
			
			this.obj_type = obj_type;
			this.key = key;
			this.value = value;
			this.prop_name = prop_name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type, key, value, prop_name);
			super.facebook_internal::initialize();
		}
	}
}