package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetObjects class represents the public  
      Facebook API known as Data.getObjects.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getObjects
	 */
	public class GetObjects extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getObjects';
		public static const SCHEMA:Array = ['obj_ids','prop_names'];
		
		public var obj_ids:Array;
		public var prop_names:Array;
		
		public function GetObjects(obj_ids:Array, prop_names:Array=null) {
			super(METHOD_NAME);
			
			this.obj_ids = obj_ids;
			this.prop_names = prop_names;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(obj_ids), FacebookDataUtils.toArrayString(prop_names));
			super.facebook_internal::initialize();
		}
	}
}