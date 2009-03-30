package com.facebook.data.notes {
	
	[Bindable]
	public class NoteData {
		
		public var note_id:String;
		public var title:String;
		public var content:String;
		public var created_time:Date;
		public var updated_time:Date;
		public var uid:String; 
		
		public function NoteData() {
			
		}

	}
}