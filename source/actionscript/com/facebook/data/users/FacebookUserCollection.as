package com.facebook.data.users {
	
	import com.facebook.utils.FacebookArrayCollection;
	
	[Bindable]
	public class FacebookUserCollection extends FacebookArrayCollection {
		
		public function FacebookUserCollection() {
			super(null, FacebookUser);
		}
		
		public function addUser(user:FacebookUser):void {
			addItem(user);
		}
		
		public function getUserById(uid:int):FacebookUser {
			return findItemByProperty('uid', uid) as FacebookUser;
		}
		
	}
}