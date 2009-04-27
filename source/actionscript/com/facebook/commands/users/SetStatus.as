/**
 * 
 * http://wiki.developers.facebook.com/index.php/Users.setStatus
 * Feb 16/09
 */ 
package com.facebook.commands.users {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The SetStatus class represents the public  
      Facebook API known as Users.setStatus.
	 * @see http://wiki.developers.facebook.com/index.php/Users.setStatus
	 */
	public class SetStatus extends FacebookCall {

		
		public static const METHOD_NAME:String = 'users.setStatus';
		public static const SCHEMA:Array = ['status', 'clear', 'status_includes_verb', 'uid'];
		
		public var status:String;
		public var clear:Boolean;
		public var status_includes_verb:Boolean;
		public var uid:String;
		
		public function SetStatus(status:String = null, clear:Boolean = false, status_includes_verb:Boolean = false, uid:String = null) {
			super(METHOD_NAME);
			
			this.status = status;
			this.clear = clear;
			this.status_includes_verb = status_includes_verb;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, status, clear, status_includes_verb, uid);
			super.facebook_internal::initialize();
		}
	} 
}