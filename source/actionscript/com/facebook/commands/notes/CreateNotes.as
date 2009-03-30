package com.facebook.commands.notes {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The CreateNotes class represents the public  
      Facebook API known as Notes.create.
	 * @see http://wiki.developers.facebook.com/index.php/Notes.create
	 */
	public class CreateNotes extends FacebookCall {

		
		public static const METHOD_NAME:String = 'notes.create';
		public static const SCHEMA:Array = ['uid','title','content'];
		
		public var uid:String;
		public var title:String;
		public var content:String;
		
		public function CreateNotes(uid:String, title:String, content:String) {
			super(METHOD_NAME);
			
			this.uid = uid;
			this.title = title;
			this.content = content;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, uid, title, content);
			super.facebook_internal::initialize();
		}
	}
}