/**
 *http://wiki.developers.facebook.com/index.php/Data.getObject 
 * FEB 24.09
 */
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetObject class represents the public  
      Facebook API known as Data.getObject.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getObject
	 */
	public class GetObject extends FacebookCall	{

		
		public static const METHOD_NAME:String = 'data.getObject';
		public static const SCHEMA:Array = ['obj_id','prop_names'];
		
		public var obj_id:String;
		public var prop_names:Array;
		
		public function GetObject(obj_id:String, prop_names:Array=null) {
			super(METHOD_NAME);
			
			this.obj_id = obj_id;
			this.prop_names = prop_names;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_id, prop_names);
			super.facebook_internal::initialize();
		}
	}
}