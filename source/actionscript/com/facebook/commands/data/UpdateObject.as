/**
 * http://wiki.developers.facebook.com/index.php/Data.updateObject
 * FEB 24.09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.data.data.NameValueData;
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The UpdateObject class represents the public  
      Facebook API known as Data.updateObject.
	 * @see http://wiki.developers.facebook.com/index.php/Data.updateObject
	 */
	public class UpdateObject extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.updateObject';
		public static const SCHEMA:Array = ['obj_id','properties','replace'];
		
		public var obj_id:String;
		public var properties:NameValueData;
		public var replace:Boolean;
		
		public function UpdateObject(obj_id:String, properties:NameValueData, replace:Boolean) {
			super(METHOD_NAME);
			
			this.obj_id = obj_id;
			this.properties = properties;
			this.replace = replace;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_id, properties, replace);
			super.facebook_internal::initialize();
		}
	}
}