package com.facebook.data.feed {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class ActionLinkCollection extends FacebookArrayCollection {
		
		public function ActionLinkCollection() {
			super(null, ActionLinkData);
		}
		
	}
}