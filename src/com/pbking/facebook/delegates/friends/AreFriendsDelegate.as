package com.pbking.facebook.delegates.friends
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.collection.HashableArray;
	
	public class AreFriendsDelegate extends FacebookDelegate
	{
		public var list1:Array;
		public var list2:Array;
		public var resultList:Array;
		
		private var totalUserCollection:HashableArray = new HashableArray("uid", false);
		
		public function AreFriendsDelegate(facebook:Facebook, list1:Array, list2:Array)
		{
			super(facebook);
			
			var user:FacebookUser;
			var uids1:Array = [];
			var uids2:Array = [];
			
			for each(user in list1)
			{
				uids1.push(user.uid);
				if(!totalUserCollection.contains(user))
					totalUserCollection.addItem(user);
			}
			
			for each(user in list2)
			{
				uids2.push(user.uid);
				if(!totalUserCollection.contains(user))
					totalUserCollection.addItem(user);
			}
			
			fbCall.setRequestArgument("uids1", uids1.join(","));
			fbCall.setRequestArgument("uids2", uids2.join(","));
			fbCall.post("facebook.friends.areFriends");
		}
		
		override protected function handleResult(result:Object):void
		{
			list1 = [];
			list2 = [];
			resultList = [];

			for each(var friendInfo:Object in result)
			{
				list1.push(totalUserCollection.getItemById(parseInt(friendInfo.uid1)));
				list2.push(totalUserCollection.getItemById(parseInt(friendInfo.uid2)));
				resultList.push(friendInfo.are_friends == 1);
			} 
		}
		
	}
}