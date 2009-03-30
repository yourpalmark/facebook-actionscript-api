package com.facebook.data.notes {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetNotesData extends FacebookData {
		
		public var notesCollection:NotesCollection;
		
		public function GetNotesData() {
			super();
		}
		
	}
}