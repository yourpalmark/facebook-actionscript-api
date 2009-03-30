package com.facebook.data.groups {
	
	[Bindable]
	public class GroupData {
		
		public var gid:String;
		public var name:String
		public var nid:Number;
		public var description:String;
		public var group_type:String;
		public var group_subtype:String;
		public var recent_news:String;
		public var pic:String;
		public var pic_big:String;
		public var pic_small:String;
		public var creator:String;
		public var update_time:Date;
		public var office:String;
		public var website:String
		public var venue:XMLList;
		public var privacy:String;
		
		public function GroupData() {
			
		}

	}
}