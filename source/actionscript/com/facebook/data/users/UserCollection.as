package com.facebook.data.users {
	
	import com.facebook.utils.FacebookArrayCollection;
	
	[Bindable]
	public class UserCollection extends FacebookArrayCollection {
		
		public function UserCollection(source:Array=null) {
			super(null, UserData);
		}
		
	}
}