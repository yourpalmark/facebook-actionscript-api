package com.facebook.commands.notes {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The EditNotes class represents the public  
      Facebook API known as Notes.edit.
	 * @see http://wiki.developers.facebook.com/index.php/Notes.edit
	 */
	public class EditNotes extends FacebookCall {

		
		public static const METHOD_NAME:String = 'notes.edit';
		public static const SCHEMA:Array = ['note_id','title','content'];
		
		public var note_id:String;
		public var title:String;
		public var content:String;
		
		public function EditNotes(note_id:String='', title:String='', content:String='') {
			super(METHOD_NAME);
			
			this.note_id = note_id;
			this.title = title;
			this.content = content;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, note_id, title, content);
			super.facebook_internal::initialize();
		}
	}
}