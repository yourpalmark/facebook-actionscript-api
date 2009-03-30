package com.facebook.commands.notes {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The DeleteNotes class represents the public  
      Facebook API known as Notes.delete.
	 * @see http://wiki.developers.facebook.com/index.php/Notes.delete
	 */
	public class DeleteNotes extends FacebookCall {

		
		public static const METHOD_NAME:String = 'notes.delete';
		public static const SCHEMA:Array = ['title','content','uid'];
		
		public var title:String;
		public var content:String;
		public var uid:String;
		
		public function DeleteNotes(title:String, content:String, uid:String='') {
			super(METHOD_NAME);
			
			this.title = title;
			this.content = content;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, title, content, uid);
			super.facebook_internal::initialize();
		}
	}
}