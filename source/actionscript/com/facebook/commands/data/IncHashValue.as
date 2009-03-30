/**
 * http://wiki.developers.facebook.com/index.php/Data.incHashValue
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The IncHashValue class represents the public  
      Facebook API known as Data.incHashValue.
	 * @see http://wiki.developers.facebook.com/index.php/Data.incHashValue
	 */
	public class IncHashValue extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.incHashValue';
		public static const SCHEMA:Array = ['obj_type','key','prop_name','increment'];
		
		public var obj_type:String;
		public var key:String;
		public var prop_name:String;
		public var increment:Number;
		
		public function IncHashValue(obj_type:String, key:String, prop_name:String, increment:Number) {
			super(METHOD_NAME);
			
			this.obj_type = obj_type;
			this.key = key;
			this.prop_name = prop_name;
			this.increment = increment;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type, key, prop_name, increment);
			super.facebook_internal::initialize();
		}
	}
}