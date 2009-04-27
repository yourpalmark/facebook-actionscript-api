/**
 * http://wiki.developers.facebook.com/index.php/Friends.get
 * Feb 10/09; 
 */
package com.facebook.commands.friends {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The GetFriends class represents the public  
      Facebook API known as Friends.get.
	 * @see http://wiki.developers.facebook.com/index.php/Friends.get
	 */
	public class GetFriends extends FacebookCall {

		
		public static const METHOD_NAME:String = 'friends.get';
		public static const SCHEMA:Array = ['flid', 'uid'];
		
		public var flid:String;
		public var uid:String;
		
		public function GetFriends(flid:String=null,uid:String=null) {
			super(METHOD_NAME);
			
			this.flid = flid;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, flid, uid);
			super.facebook_internal::initialize();
		}
	}
}