package com.facebook.data.groups {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class GroupCollection extends FacebookArrayCollection {
		
		public function GroupCollection() {
			super(null, GroupData);
		}
		
		public function addGroup(group:GroupData):void {
			this.addItem(group);
		}
	}
}