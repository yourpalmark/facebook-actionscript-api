package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetAssociatedObjectCount class represents the public  
      Facebook API known as Data.getAssociatedObjectCount.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getAssociatedObjectCount
	 */
	public class GetAssociatedObjectCount extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getAssociatedObjectCount';
		public static const SCHEMA:Array = ['name','obj_id'];
		
		public var name:String;
		public var obj_id:String;
		
		public function GetAssociatedObjectCount(name:String, obj_id:String) {
			super(METHOD_NAME);
			
			this.name = name;
			this.obj_id = obj_id;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, obj_id);
			super.facebook_internal::initialize();
		}
	}
}