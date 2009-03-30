
/**
 *http://wiki.developers.facebook.com/index.php/Photos.getTags
 *Feb 16/09
 *Online documentation pids required but class does not require pid
 */ 
package com.facebook.commands.photos {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetTags class represents the public  
      Facebook API known as Photos.getTags.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Photos.getTags
	 */
	public class GetTags extends FacebookCall {

		
		public static var METHOD_NAME:String = 'photos.getTags';
		public static var SCHEMA:Array = ['pids'];
		
		public var pids:Array;
		
		public function GetTags(pids:Array=null) {
			super(METHOD_NAME);
			
			this.pids = pids;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(pids));
			super.facebook_internal::initialize();
		}
		
	}
}

