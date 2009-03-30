/**
 * http://wiki.developers.facebook.com/index.php/Photos.get
 *
 * Feb 16/09 
 */ 
package com.facebook.commands.photos {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetPhotos class represents the public  
      Facebook API known as Photos.get.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Photos.get
	 */
	public class GetPhotos extends FacebookCall {

		
		public static var METHOD_NAME:String = 'photos.get';
		public static var SCHEMA:Array = ['subj_id','aid','pids'];
		
		protected var subj_id:String;
		protected var aid:String;
		protected var pids:Array;
		
		public function GetPhotos(subj_id:String='',aid:String="",pids:Array=null) {
			super(METHOD_NAME);
			
			this.subj_id = subj_id;
			this.aid = aid;
			this.pids = pids;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, subj_id, aid, FacebookDataUtils.toArrayString(pids));
			super.facebook_internal::initialize();
		}
	}
}