/**
 *http://wiki.developers.facebook.com/index.php/Data.removeHashKey
 * FEB 24.09
 */  
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The RemoveHashKey class represents the public  
      Facebook API known as Data.removeHashKey.
	 * @see http://wiki.developers.facebook.com/index.php/Data.removeHashKey
	 */
	public class RemoveHashKey extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.removeHashKey';
		public static const SCHEMA:Array = ['obj_type','key'];
		
		public var obj_type:String;
		public var key:String;
		
		public function RemoveHashKey(obj_type:String, key:String) {
			super(METHOD_NAME);
			
			this.obj_type = obj_type;
			this.key = key;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type, key);
			super.facebook_internal::initialize();
		}
	}
}