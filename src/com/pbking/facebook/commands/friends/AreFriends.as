package com.pbking.facebook.delegates.friends
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.util.collection.HashableArray;
	
	public class AreFriendsDelegate extends FacebookCall
	{
		public var list1:Array;
		public var list2:Array;
		
		public var resultList:Array;
		
		private var totalUserCollection:HashableArray = new HashableArray("uid", false);
		
		public function AreFriendsDelegate(list1:Array=null, list2:Arraynull)
		{
			super("facebook.friends.areFriends");
			
			this.list1 = list1;
			this.list2 = list2;
		}
		
		override public function initialize():void
		{
			var user:FacebookUser;
			var uids1:Array = [];
			var uids2:Array = [];
			
			for (var i:int=0; i<list1.length; i++)
			{
				if(list1[i] is FacebookUser)
					user = list1[i] as FacebookUser;
				else
					user = FacebookUser.getUser(list1[i]);
				
				uids1.push(user.uid);

				if(!totalUserCollection.contains(user))
					totalUserCollection.addItem(user);
			}
			
			for (var j:int=0; j<list2.length; j++)
			{
				if(list2[j] is FacebookUser)
					user = list2[j] as FacebookUser;
				else
					user = FacebookUser.getUser(list2[j]);
				
				uids2.push(user.uid);

				if(!totalUserCollection.contains(user))
					totalUserCollection.addItem(user);
			}
			

			setRequestArgument("uids1", uids1.join(","));
			setRequestArgument("uids2", uids2.join(","));
		}
		
		override protected function handleSuccess(result:Object):void
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