/**
 * uid parameter if not included gives your albums
 * aid parameter is not rquired to get a list of albums
 * Feb 13/09
 */
package com.facebook.commands.photos {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;
	
	use namespace facebook_internal;
	
	/**
	 * The GetAlbums class represents the public  
      Facebook API known as Photos.getAlbums.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Photos.getAlbums
	 */
	public class GetAlbums extends FacebookCall {

		
		public static const METHOD_NAME:String = 'photos.getAlbums';
		public static const SCHEMA:Array = ['uid','aids'];
		
		public var uid:String;
		public var aids:Array;
		
		public function GetAlbums(uid:String='', aids:Array=null) {
			
			super(METHOD_NAME);
			
			this.uid = uid
			this.aids = aids;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid, FacebookDataUtils.toArrayString(aids));
			super.facebook_internal::initialize();
		}
	}
}