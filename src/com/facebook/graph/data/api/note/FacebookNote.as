package com.facebook.graph.data.api.note
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * A Facebook note.
	 * @see http://developers.facebook.com/docs/reference/api/note
	 */
	public class FacebookNote extends AbstractFacebookGraphObject
	{
		/**
		 * The profile that created the note.
		 */
		public var from:Object;
		
		/**
		 * The title of the note.
		 */
		public var subject:String;
		
		/**
		 * The content of the note.
		 */
		public var message:String;
		
		/**
		 * The time the note was initially published.
		 */
		public var created_time:Date;
		
		/**
		 * The time the note was last updated.
		 */
		public var updated_time:Date;
		
		/**
		 * The icon that Facebook displays with notes.
		 */
		public var icon:String;
		
		/**
		 * Creates a new FacebookNote.
		 */
		public function FacebookNote()
		{
		}
		
		/**
		 * Populates and returns a new FacebookNote from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookNote.
		 */
		public static function fromJSON( result:Object ):FacebookNote
		{
			var note:FacebookNote = new FacebookNote();
			note.fromJSON( result );
			return note;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ FacebookNoteField.ID, FacebookNoteField.SUBJECT ] );
		}
		
	}
}