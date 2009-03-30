package com.facebook.commands.notes {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetNotes class represents the public  
      Facebook API known as Notes.get.
         * <p>This class represents a Facebook API that requires a session key, whether the API is called
      by a web session or a desktop session.</p>
	 * @see http://wiki.developers.facebook.com/index.php/Category:Session_Required_API
	 * @see http://wiki.developers.facebook.com/index.php/Notes.get
	 */
	public class GetNotes extends FacebookCall {

		
		public static const METHOD_NAME:String = 'notes.get';
		public static const SCHEMA:Array = ['uid'];
		
		public var uid:String;
		
		public function GetNotes(uid:String='') {
			super(METHOD_NAME);
			
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid);
			super.facebook_internal::initialize();
		}
	}
}