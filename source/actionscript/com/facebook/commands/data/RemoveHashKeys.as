/**
 * http://wiki.developers.facebook.com/index.php/Data.removeHashKeys
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The RemoveHashKeys class represents the public  
      Facebook API known as Data.removeHashKeys.
	 * @see http://wiki.developers.facebook.com/index.php/Data.removeHashKeys
	 */
	public class RemoveHashKeys extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.removeHashKeys';
		public static const SCHEMA:Array = ['obj_type', 'keys'];
		
		public var obj_type:String;
		public var keys:Array;
		
		public function RemoveHashKeys(obj_type:String, keys:Array) {
			super(METHOD_NAME);
			
			this.obj_type = obj_type;
			this.keys = keys;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type, keys);
			super.facebook_internal::initialize();
		}
	}
}