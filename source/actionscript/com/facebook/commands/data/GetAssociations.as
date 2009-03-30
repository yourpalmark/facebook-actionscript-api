/**
 * http://wiki.developers.facebook.com/index.php/Data.getAssociations
 * Feb 23/09
 */
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetAssociations class represents the public  
      Facebook API known as Data.getAssociations.
	 * @see http://wiki.developers.facebook.com/index.php/Data.getAssociations
	 */
	public class GetAssociations extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.getAssociations';
		public static const SCHEMA:Array = ['obj_id1','obj_id2','no_data'];
		
		public var obj_id1:String;
		public var obj_id2:String;
		public var no_data:Boolean;
		
		public function GetAssociations(obj_id1:String, obj_id2:String, no_data:Boolean = true) {
			super(METHOD_NAME);
			
			this.obj_id1 = obj_id1;
			this.obj_id2 = obj_id2;
			this.no_data = no_data;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, obj_id1, obj_id2, no_data);
			super.facebook_internal::initialize();
		}
	}
}