/**
 * http://wiki.developers.facebook.com/index.php/Admin.getAllocation
 * March 23, 2009
 */ 
package com.facebook.commands.admin {
	
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	/**
	 * The GetAllocation class represents the public  
      Facebook API known as Admin.getAllocation.
	 * @see http://wiki.developers.facebook.com/index.php/Admin.getAllocation
	 */
	public class GetAllocation extends FacebookCall {

		
		public static const METHOD_NAME:String = 'admin.getAllocation';
		public static const SCHEMA:Array = ['integration_point_name'];
		
		public var integration_point_name:String;
		public var user:String;
		
		public function GetAllocation(integration_point_name:String, user:String = null) {
			super(METHOD_NAME);
			
			this.integration_point_name = integration_point_name;
			this.user = user;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, this.integration_point_name);
			super.facebook_internal::initialize();
		}
	}
}