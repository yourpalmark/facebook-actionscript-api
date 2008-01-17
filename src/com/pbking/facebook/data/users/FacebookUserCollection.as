package com.pbking.facebook.data.users
{
	import com.pbking.util.collection.HashableArray;

	[Bindable]
	public class FacebookUserCollection extends HashableArray
	{
		function FacebookUserCollection()
		{
			super('uid', false);
		}
		
		public function addUser(user:FacebookUser):void
		{
			this.addItem(user);
		}
		
		public function getUserById(uid:int):FacebookUser
		{
			return this.getItemById(uid) as FacebookUser;
		}
	}
}