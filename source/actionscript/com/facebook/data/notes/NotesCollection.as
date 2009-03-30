package com.facebook.data.notes {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class NotesCollection extends FacebookArrayCollection {
		
		public function NotesCollection() {
			super(null, NoteData);
		}
		
	}
}