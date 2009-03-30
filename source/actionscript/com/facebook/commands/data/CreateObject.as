/**
 * http://wiki.developers.facebook.com/index.php/Data.createObject
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.data.data.NameValueData;
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The CreateObject class represents the public  
      Facebook API known as Data.createObject.
	 * @see http://wiki.developers.facebook.com/index.php/Data.createObject
	 */
	public class CreateObject extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.createObject';
		public static const SCHEMA:Array = ['obj_type','properties'];
		
		protected var obj_type:String;
		protected var properties:*;
		
		public function CreateObject(obj_type:String, properties:*=null) {
			super(METHOD_NAME);
			
			this.obj_type = obj_type;
			this.properties = properties;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_type, properties);
			super.facebook_internal::initialize();
		}
	}
}