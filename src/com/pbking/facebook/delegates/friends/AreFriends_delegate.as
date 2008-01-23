package com.pbking.facebook.delegates.friends
{
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.collection.HashableArray;
	import com.pbking.util.logging.PBLogger;
	
	public class AreFriends_delegate extends FacebookDelegate
	{
		public var list1:Array;
		public var list2:Array;
		public var resultList:Array;
		
		private var totalUserCollection:HashableArray = new HashableArray("uid", false);
		
		public function AreFriends_delegate(list1:Array, list2:Array)
		{
			PBLogger.getLogger("pbking.facebook").debug("getting areFriends");
			
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
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			list1 = [];
			list2 = [];
			resultList = [];

			var xFriendsList:XMLList = resultXML..friend_info;
			for each(var xFriendInfo:XML in xFriendsList)
			{
				list1.push(totalUserCollection.getItemById(int(xFriendInfo.uid1)));
				list2.push(totalUserCollection.getItemById(int(xFriendInfo.uid2)));
				resultList.push(xFriendInfo.are_friends == 1);
			} 
		}
		
	}
}